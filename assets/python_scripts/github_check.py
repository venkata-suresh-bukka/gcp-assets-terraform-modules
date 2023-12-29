# from github import Github

# # Replace with your personal access token
# ACCESS_TOKEN = "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"

# # Replace with the name of the repository to search
# REPO_NAME = "demo"

# # Create a Github instance using the access token
# g = Github(ACCESS_TOKEN)

# # Get the repository
# repo = g.get_repo(REPO_NAME)

# # Define a function to search for JSON files in a directory
# def search_for_json_files(directory):
#     contents = repo.get_contents(directory)
#     for content_file in contents:
#         if content_file.type == "dir":
#             # If the content is a directory, recursively search it
#             search_for_json_files(content_file.path)
#         elif content_file.name.endswith(".json"):
#             # If the content is a JSON file, print its path
#             print(content_file.path)

# # Call the search_for_json_files function on the root directory of the repository
# search_for_json_files("")


# import requests

# # GitHub API endpoint for getting repository contents
# url = 'https://api.github.com/repos/{owner}/{repo}/contents'

# # Replace {owner} and {repo} with your repository information
# owner = 'venkat-0007'
# repo = 'demo'

# response = requests.get(url.format(owner=owner, repo=repo))

# # Check if the response was successful
# if response.status_code == requests.codes.ok:
#     contents = response.json()
    
#     # Loop through the contents and check if any files have a .json extension
#     for item in contents:
#         if item['type'] == 'file' and item['name'].endswith('.json'):
#             print(f"{item['name']} is a .json file in the repository")
# else:
#     # Handle the case where the API request was unsuccessful
#     print("Error: API request failed")


# import os
# import requests

# # GitHub API endpoint for getting repository contents
# url = 'https://api.github.com/repos/{owner}/{repo}/contents'

# # Replace {owner} and {repo} with your repository information
# owner = 'venkat-0007'
# repo = 'demo'
# directory = 'src'  # replace with the path to the directory you want to check

# # Make a request to the GitHub API to get the contents of the directory
# response = requests.get(url.format(owner=owner, repo=repo, path=directory))

# # Check if the response was successful
# if response.status_code == requests.codes.ok:
#     contents = response.json()

#     # Loop through the contents and check if any files have a .json extension
#     for item in contents:
#         if item['type'] == 'file' and item['name'].endswith('.json'):
#             print(f"{item['name']} is a .json file in {directory}")
# else:
#     # Handle the case where the API request was unsuccessful
#     print(f"Error: API request failed with status code {response.status_code}")

# # Check if the directory exists locally
# if os.path.exists(directory):
#     # Loop through the directory and check if any files have a .json extension
#     for filename in os.listdir(directory):
#         if filename.endswith('.json'):
#             print(f"{filename} is a .json file in {directory}")
# else:
#     # Handle the case where the directory does not exist
#     print(f"Error: Directory {directory} not found")


import requests

# GitHub API endpoint for getting repository contents
url = 'https://api.github.com/repos/{owner}/{repo}/contents'

# Replace {owner} and {repo} with your repository information
owner = 'venkat-0007'
repo = 'demo'

# Replace {access_token} with a personal access token that has repository access
headers = {
    'Authorization': f'token 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',
    'Accept': 'application/vnd.github.v3+json'
}

# Set to keep track of visited directories
visited_directories = set()

def check_for_json_files(path):
    # Check if the path has already been visited
    if path in visited_directories:
        return
    visited_directories.add(path)

    # Make a request to the GitHub API to get the contents of the path
    response = requests.get(url.format(owner=owner, repo=repo, path=path), headers=headers)

    # Check if the response was successful
    if response.status_code == requests.codes.ok:
        contents = response.json()

        # Loop through the contents and check if any files have a .json extension
        for item in contents:
            if item['type'] == 'file' and item['name'].endswith('.json'):
                print(f"{item['name']} is a .json file in {path}")
            elif item['type'] == 'dir':
                # Recursively check for .json files in subdirectories
                check_for_json_files(item['path'])
    else:
        # Handle the case where the API request was unsuccessful
        print(f"Error: API request failed with status code {response.status_code}")

# Start by checking the root directory of the repository
check_for_json_files('')
