# GitHub Copilot / AI Agent Instructions — Terraform Zero to Hero

Short: This repo is a course-style collection of Terraform lessons and hands-on projects. Aim to keep changes small, reproducible, and aligned with the Day-N lesson where the examples live.

## Big picture
- Structure: each lesson lives under `Day-*/` (notes + example `.tf` files). Practice projects are under `practice/` and full projects are under `Day-*/PROJECT-*/`.
- Reusable modules live under `Day-3/modules/` and `Day-6/modules/` (e.g., `ec2_instance` with `main.tf`, `variables.tf`, `outputs.tf`). See `Day-3/modules/ec2_instance/*` for canonical module patterns.
- State: some sample `terraform.tfstate` files are committed under `practice/` (for exercises). Treat any committed state as sample data only — do not update or commit real state files.

## Developer workflows (explicit commands)
- Local validation and formatting (recommended):
  - `terraform fmt -recursive` — format all HCL
  - `terraform validate` — check configuration
  - `terraform init` — initialize working directory (run inside the lesson/project dir)
  - `terraform plan -out=plan.tfplan` and `terraform apply plan.tfplan` (or `terraform apply -auto-approve` for throwaway tests)
  - `terraform destroy -auto-approve` — clean up resources after testing
- When changing remote state/backends, consult `Day-4/backend.tf` which shows an S3 + DynamoDB locking example (update docs when changing backend configuration).

## Project-specific conventions & patterns (what to look for)
- Single-file lesson projects use `main.tf` as the root config.
- Providers/config are sometimes declared in the same folder (e.g., `provider "aws" { region = "us-east-1" }` in module examples). When adding real CI or cross-workspace changes, prefer centralized provider configuration.
- Modules follow the pattern: `modules/<name>/main.tf`, `modules/<name>/variables.tf`, `modules/<name>/outputs.tf`. Example usage from this repo:

```hcl
module "example_ec2" {
  source            = "../modules/ec2_instance"
  ami_value         = "ami-..."
  instance_type_value = "t2.micro"
  subnet_id_value   = aws_subnet.sub1.id
}
```

- Example that uses user-data scripts: `Day-2/PROJECT-vpc-with-ec2` references `userdata.sh` with `user_data = base64encode(file("userdata.sh"))`. Be careful: scripts assume an Ubuntu-like OS and apt package manager.
- Outputs and naming: review outputs in modules (e.g., `output "public-ip-address"` in `Day-3/modules/ec2_instance/outputs.tf`) and keep changes compatible with callers.

## Integration points & gotchas
- AWS provider is the primary integration (see many `aws_*` resources across Day folders). Many examples hardcode AMI IDs and regions (`us-east-1`) — AMIs become stale; prefer using data sources or documented variables when updating examples.
- Sample S3 backend config is in `Day-4/backend.tf` (bucket name needs to be changed before use). If you modify backend docs or config, update `Day-4/statefile_scenarios.md` and add a short note describing required bucket/table changes and any migration steps.

## Debugging & testing tips
- Use `terraform plan` to inspect intended changes; prefer `terraform plan -out=plan.tfplan` then `terraform apply plan.tfplan` when possible.
- Use `terraform console` and `terraform state list`/`terraform state show` for troubleshooting and exploring current state.
- Run `terraform fmt -recursive` and `terraform validate` before creating PRs. Consider adding `tflint`/`checkov` to CI for policy/lint checks if/when CI is added.

## Files to inspect when you start
- `README.md` — course overview
- `Day-1/..` through `Day-7/..` — lesson notes and examples
- `Day-3/modules/ec2_instance/*` — module canonical pattern (see `main.tf`, `variables.tf`, `outputs.tf`)
- `Day-2/PROJECT-vpc-with-ec2/*` — full project demonstrating user-data scripts (`userdata.sh`, `userdata1.sh`), ALB, and multiple subnets
- `Day-4/backend.tf` — S3 + DynamoDB locking example

## PR guidance & safety
- Keep changes small, focused, and aligned to the Day lesson. When updating examples, update the lesson `.md` and example `.tf` files together so learners see consistent content.
- Do not modify `practice/*/terraform.tfstate` except when explicitly fixing sample data for a lesson. Treat committed state files as samples only — never commit real state or credentials.

If anything above is unclear or you want additional examples (CI snippets, suggested linter rules, or a sample GitHub Actions job), tell me which section you'd like expanded and I will iterate.