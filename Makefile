#      _
#  ___| |_ _____      __
# / __| __/ _ \ \ /\ / /
# \__ \ || (_) \ V  V /
# |___/\__\___/ \_/\_/
#
PACKAGES=$(shell /bin/bash -c 'ls -d */')

stow:
	@echo "Stowing packages: [${PACKAGES}]"
	@stow --no-folding --ignore='^.*(bash|\.git).*$$' --verbose=1 ${PACKAGES}
	@echo "Done!"

delete:
	@echo "Deleting packages: [${PACKAGES}]"
	@stow -D --verbose=1 ${PACKAGES}
	@echo "Done!"

restow:
	@echo "Re-stowing packages: [${PACKAGES}]"
	@stow -R --verbose=1 ${PACKAGES}
	@echo "Done!"
