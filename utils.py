import os


def get_file_name_of_newest_database():
    base_name = "database"
    counter = 1

    # Increment counter until a new file name is found
    while os.path.exists(f"{base_name}{counter}.db"):
        counter += 1
    counter -= 1
    return f"{base_name}{counter}.db"


def generate_new_database_filename():
    base_name = "database"
    counter = 1

    # Increment counter until a new file name is found
    while os.path.exists(f"{base_name}{counter}.db"):
        counter += 1

    return f"{base_name}{counter}.db"
