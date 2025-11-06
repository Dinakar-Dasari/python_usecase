import requests
from dotenv import dotenv_values

user_name = "Dinakar-Dasari"
config = dotenv_values(".env")
github_token = config.get("github_token")
base_URL = f"https://api.github.com/users/{user_name}/repos"
HEADERS = {'Authorization': f'token {github_token}'}

def list_repos(user_name):
    repos= []
    URL = base_URL
    while URL:
        response = requests.get(URL, headers=HEADERS, params={"per_page":100})
        if response.status_code == 200:
            data = response.json()
            repos.extend(data)
            # Pagination: get next page if available
            URL = response.links.get("next", {}).get("URL")            
        else:
            print(f"Failed to fetch repos: {response.status_code} - {response.text}")
            break
        
# Print the names of the repositories
    for repo in repos:
        print(repo["name"])

list_repos(user_name)



