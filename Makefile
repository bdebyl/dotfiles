#      _
#  ___| |_ _____      __
# / __| __/ _ \ \ /\ / /
# \__ \ || (_) \ V  V /
# |___/\__\___/ \_/\_/
#
PACKAGES=$(shell /bin/bash -c 'ls -d */')

stow:
	@echo "Stowing packages: [${PACKAGES}]"
	@stow ${PACKAGES}
	@echo "Done!"

delete:
	@echo "Deleting packages: [${PACKAGES}]"
	@stow -D ${PACKAGES}
	@echo "Done!"

restow:
	@echo "Re-stowing packages: [${PACKAGES}]"
	@stow -R ${PACKAGES}
	@echo "Done!"
