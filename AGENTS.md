# build-service infrastructure

Terraform for the build service's development environment. This repo is
VCS-connected to the HCP Terraform workspace `ai-devops-demo` (org
`demo-vault-platform-tour`, project `ai-devops-demo`). Runs are triggered by
GitHub, not by the CLI: a pull request triggers a speculative plan plus
policy checks, and a merge to `main` triggers the real plan and apply.

The Terraform MCP server is configured in `.mcp.json`. It is your only
window into HCP Terraform: use it to discover approved modules and to read
run and policy results. It is read-only for this workspace by design.

## Workflow (always follow this)

1. Never run `terraform plan` or `terraform apply` locally, and never add a
   backend or cloud block. GitHub is the only path to a run. Do not create
   runs through the MCP server either; that tool is intentionally absent.
2. Before writing any module call, look the module up in the org's private
   registry through the MCP server (`search_private_modules`, then
   `get_private_module_details`) and use the documented inputs, outputs, and
   the latest version. Do not guess module interfaces.
3. Work on a feature branch, never commit directly to `main`.
4. Commit with your own identity so the change is attributed to you:
   `git -c user.name="build-ai-agent" -c user.email="ai-agent@example.internal" commit ...`
5. Push the branch and open a pull request with `gh pr create`, describing
   what you are provisioning and why.
6. HCP Terraform posts its plan and policy results as status checks on the
   pull request. Wait for them (`gh pr checks --watch`). To read the details,
   use the MCP server: `list_runs` for the workspace, then `get_run_details`
   for the newest run, which includes the policy check results and their
   output.
7. If a run fails a policy check, read the policy output, adjust the
   configuration to comply, briefly note in the PR what you changed and why,
   and push again. Do not attempt to bypass, override, or disable a policy.
8. You may not merge. A human reviews and merges the pull request; the
   workspace applies automatically on merge. After asking for review, stop.

## Conventions

- S3 buckets come from the org's private registry module
  (`app.terraform.io/demo-vault-platform-tour/s3-bucket/aws`). Compute and
  networking may be written as plain AWS resources.
- One logical component per file, named for the component (for example
  `compute.tf`, `storage.tf`, `network.tf`).
- Runs are subject to the platform team's Sentinel policy set. Policy
  output is the source of truth for the org's standards.
- Scope: this repository only. Do not create or modify workspaces,
  variables, teams, or anything outside this configuration.
- `.mcp.json`, `.gitignore`, and `.claude/` are governance files. Do not
  edit them; if a change is genuinely required, ask a human.
