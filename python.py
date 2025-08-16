import streamlit as st
import mysql.connector
import pandas as pd
from datetime import date

# Database connection function
def get_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Shrajan@1233",
        database="project"
    )

# Function to execute a SELECT query and return results as a DataFrame
def run_query(query, params=None):
    conn = get_connection()
    cursor = conn.cursor()
    if params:
        cursor.execute(query, params)
    else:
        cursor.execute(query)
    data = cursor.fetchall()
    columns = [col[0] for col in cursor.description]
    conn.close()
    return pd.DataFrame(data, columns=columns)

# Function to execute an INSERT/UPDATE/DELETE query
def run_action(query, values):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(query, values)
    conn.commit()
    conn.close()

# User authentication function with plain text passwords
def authenticate(username, password):
    query = "SELECT password FROM Users WHERE username = %s"
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(query, (username,))
    result = cursor.fetchone()
    conn.close()
    if result and result[0] == password:
        return True
    else:
        return False

# Streamlit App
st.title("Parliamentary Management System")

# Initialize session state for login
if "logged_in" not in st.session_state:
    st.session_state.logged_in = False

# Login Page
if not st.session_state.logged_in:
    st.subheader("Login")
    username = st.text_input("Username")
    password = st.text_input("Password", type="password")
    if st.button("Login"):
        if authenticate(username, password):
            st.session_state.logged_in = True
            st.success("Login successful")
        else:
            st.error("Invalid username or password")
else:
    # Sidebar Navigation
    pages = ["MPs", "Constituencies", "Parties", "Bills", "Committees", "Sessions", "Votes"]
    page = st.sidebar.selectbox("Choose a page", pages)

    # Function to display the form for adding a record
    def display_add_form(columns, table_name):
        with st.form("Add Form"):
            values = []
            for col in columns:
                if col == "DOB" or col.endswith("date"):
                    value = st.date_input(col, value=date(1970, 1, 1), min_value=date(1970, 1, 1), max_value=date.today())
                elif col == "Age":
                    value = st.number_input(col, min_value=18, max_value=100)
                else:
                    value = st.text_input(col)
                values.append(value)
            submitted = st.form_submit_button("Add")
            if submitted:
                placeholders = ", ".join(["%s"] * len(columns))
                query = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({placeholders})"
                run_action(query, tuple(values))
                st.success(f"Record added to {table_name}")

    # Function to display the form for editing a record
    def display_edit_form(df, table_name, id_column):
        ids = {row[id_column]: row for index, row in df.iterrows()}
        selected_id = st.selectbox("Choose a record to edit", list(ids.keys()))
        record = ids[selected_id]

        with st.form("Edit Form"):
            values = []
            for col in df.columns:
                if col == id_column:
                    value = record[col]
                    st.text_input(col, value=value, disabled=True)
                elif col == "DOB" or col.endswith("date"):
                    value = st.date_input(col, value=pd.to_datetime(record[col]), min_value=date(1970, 1, 1), max_value=date.today())
                elif col == "Age":
                    value = st.number_input(col, value=record[col], min_value=18, max_value=100)
                else:
                    value = st.text_input(col, value=record[col])
                values.append(value)
            submitted = st.form_submit_button("Update")
            if submitted:
                # Remove the disabled id_column from the values list
                update_values = values[1:]
                set_clause = ", ".join([f"{col} = %s" for col in df.columns if col != id_column])
                query = f"UPDATE {table_name} SET {set_clause} WHERE {id_column} = %s"
                run_action(query, tuple(update_values + [selected_id]))
                st.success(f"Record updated in {table_name}")

    # Function to delete a record
    def delete_record(df, table_name, id_column):
        ids = {row[id_column]: row for index, row in df.iterrows()}
        selected_id = st.selectbox("Choose a record to delete", list(ids.keys()))
        if st.button("Delete"):
            query = f"DELETE FROM {table_name} WHERE {id_column} = %s"
            run_action(query, (selected_id,))
            st.success(f"Record deleted from {table_name}")

    # Page for handling different tables
    if page == "MPs":
        st.header("Members of Parliament")
        action = st.selectbox("Choose action", ["View", "Add", "Edit", "Delete"])
        columns = ["MP_ID", "FName", "LName", "DOB", "PhNo", "Age"]
        table_name = "Member_of_Parliament"
        id_column = "MP_ID"
    elif page == "Constituencies":
        st.header("Constituencies")
        action = st.selectbox("Choose action", ["View", "Add", "Edit", "Delete"])
        columns = ["C_ID", "Name", "Region"]
        table_name = "Constituency"
        id_column = "C_ID"
    elif page == "Parties":
        st.header("Parties")
        action = st.selectbox("Choose action", ["View", "Add", "Edit", "Delete"])
        columns = ["P_ID", "Name", "Leader"]
        table_name = "Party"
        id_column = "P_ID"
    elif page == "Bills":
        st.header("Bills")
        action = st.selectbox("Choose action", ["View", "Add", "Edit", "Delete"])
        columns = ["Bill_ID", "Title", "Date_intro", "MP_ID"]
        table_name = "Bill"
        id_column = "Bill_ID"
    elif page == "Committees":
        st.header("Committees")
        action = st.selectbox("Choose action", ["View", "Add", "Edit", "Delete"])
        columns = ["Committee_ID", "Name", "Chairperson_ID"]
        table_name = "Committee"
        id_column = "Committee_ID"
    elif page == "Sessions":
        st.header("Sessions")
        action = st.selectbox("Choose action", ["View", "Add", "Edit", "Delete"])
        columns = ["Session_ID", "Start_date", "End_date"]
        table_name = "Session"
        id_column = "Session_ID"
    elif page == "Votes":
        st.header("Votes")
        action = st.selectbox("Choose action", ["View", "Add", "Edit", "Delete"])
        columns = ["Vote_ID", "Bill_ID", "MP_ID", "Vote"]
        table_name = "Vote"
        id_column = "Vote_ID"

    if action == "View":
        df = run_query(f"SELECT * FROM {table_name}")
        st.write(df)
    elif action == "Add":
        display_add_form(columns, table_name)
    elif action == "Edit":
        df = run_query(f"SELECT * FROM {table_name}")
        display_edit_form(df, table_name, id_column)
    elif action == "Delete":
        df = run_query(f"SELECT * FROM {table_name}")
        delete_record(df, table_name, id_column)
