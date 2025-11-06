#### Why we need to generate access token even though if we list only public repos
+ Ideally, we don’t need a token to list public repositories using the GitHub API.
+ But, GitHub allows around 60 unauthenticated requests per hour which is often insufficient for CI/CD tools, integrations, or web applications. But with a token, you can make up to 5,000 per hour
+ Because if we run the script in the pipeline or automate then it might do API calls multiple times.
+ Also, It allows access to private repos, if the token has the right permissions.
+ The **headers** carry metadata (auth info, content type, etc.) 
