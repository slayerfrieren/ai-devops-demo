# payments-service platform infrastructure

Terraform for the payments-service landing zone. This repo is VCS-connected
to the HCP Terraform workspace `ai-devops-demo` (org `demo-vault-platform-tour`).
Runs are triggered by GitHub, not by the CLI: a pull request triggers a
speculative plan plus policy checks, and a merge to `main` triggers the real
plan and apply.

## Workflow (always follow this)

1. Never run `terraform plan` or `terraform apply` locally, and never add a
   backend or cloud block. GitHub is the only path to a run.
2. Work on a feature branch, never commit directly to `main`.
3. Commit with your own identity so the change is attributed to you:
   `git -c user.name="payments-ai-agent" -c user.email="ai-agent@plazafederal.example" commit ...`
4. Push the branch and open a pull request with `gh pr create`, describing
   what you are provisioning and why.
5. HCP Terraform posts its plan and policy results as status checks on the
   pull request. Wait for them (`gh pr checks --watch`). To read the details
   of a run (plan output, policy check output), use the HCP Terraform API
   with the token in `TF_TOKEN_app_terraform_io`: list runs for the
   workspace, then fetch the run's `policy-checks` and their output.
6. If a run fails a policy check, read the policy output, adjust the
   configuration to comply, briefly note in the PR what you changed and why,
   and push again. Do not attempt to bypass, override, or disable a policy.
7. You may not merge. A human reviews and merges the pull request; the
   workspace applies automatically on merge. After asking for review, stop.

## Conventions

- S3 buckets come from the org's private registry module
  (`app.terraform.io/demo-vault-platform-tour/s3-bucket/aws`). Networking,
  compute, load balancing and databases may be written as plain AWS
  resources.
- One logical component per file, named for the component (for example
  `network.tf`, `compute.tf`, `database.tf`, `storage.tf`).
- Runs are subject to the platform team's Sentinel policy set. Policy
  output is the source of truth for the org's standards.
- Scope: this repository only. Do not create or modify workspaces,
  variables, teams, or anything outside this configuration.
