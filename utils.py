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


# def chooseUserInput(option_list, option_index=0):
#     """
#     Function to choose a value from a list of options
#     params:
#     option_list: list of options list
#     """
#     option_string = "\n".join(
#         [f"{i+1}. {option[option_index]}" for i, option in enumerate(option_list)]
#     )
#     selected_value = input(f"Velg en dato basert på index: \n {option_string}")
#     if (
#         selected_value.isdigit()
#         and int(selected_value) <= len(option_list)
#         and int(selected_value) > 0
#     ):
#         selected_value = option_list[int(selected_value) - 1]
#         return selected_value
#     elif (
#         selected_value == "q"
#         or selected_value == ""
#         or selected_value == None
#         or selected_value == "exit"
#     ):
#         raise SystemExit("Unvalid input!")
#     else:
#         chooseUserInput(option_list, option_index)


def chooseUserInput(option_list, option_index=[0], input_text="Velg basert på index: "):
    """
    Function to choose a value from a list of options
    params:
    option_list: list of options list
    option_index: list of indexes to choose from each option
    """
    option_string = "\n".join(
        [
            f"( Alternativ {i+1}: {' '.join([str(option[idx]) for idx in option_index])} )  "
            for i, option in enumerate(option_list)
        ]
    )
    selected_value = input(f"{input_text} {option_string}")
    if (
        selected_value.isdigit()
        and int(selected_value) <= len(option_list)
        and int(selected_value) > 0
    ):
        selected_value = option_list[int(selected_value) - 1]
        return selected_value
    elif (
        selected_value == "q"
        or selected_value == ""
        or selected_value == None
        or selected_value == "exit"
    ):
        raise SystemExit("Unvalid input!")
    else:
        chooseUserInput(option_list, option_index)
