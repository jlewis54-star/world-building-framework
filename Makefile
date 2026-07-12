.PHONY: validate validate-changed validate-canon world-dashboard list-projects

validate:
	./scripts/validate.sh

validate-changed:
	./scripts/validate.sh --changed

validate-canon:
	./scripts/check_canon_version.sh

world-dashboard:
	./scripts/world-type-dashboard.sh

list-projects:
	./scripts/list-open-projects.sh
