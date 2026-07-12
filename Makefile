.PHONY: validate validate-changed

validate:
	./scripts/validate.sh

validate-changed:
	./scripts/validate.sh --changed
