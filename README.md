# build-service infrastructure

Development environment for the build service, managed with Terraform
through HCP Terraform (VCS-connected workspace `ai-devops-demo`). Changes
land by pull request: plans and policy checks run on the PR, and merges to
`main` apply automatically. Coding agents discover approved modules and read
run results through the Terraform MCP server (`.mcp.json`). See `AGENTS.md`
for the workflow when working in this repo with a coding agent.
