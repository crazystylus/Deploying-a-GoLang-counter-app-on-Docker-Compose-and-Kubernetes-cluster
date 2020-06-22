#!/bin/sh

set -u

main() {
	# Checking for vagrant
	if ! cmd_chk "vagrant"; then
		error "Please install Vagrant"
	fi
	# Checking for python
	if ! cmd_chk "python"; then
		error "Please install Python"
	fi
	# Checking for virtualbox
	if ! cmd_chk "virtualbox"; then
		error "Please install virtualbox"
	fi
	# Checking for ansible
	if ! cmd_chk "ansible"; then
		if cmd_chk "pip"; then
			error "pip not found. Cannot install ansible"
		else
			info "Installing ansible through pip"
			pip install ansible
		fi
	fi
	success "All dependencies met"
	info "Starting box with vagrant"
	ensure vagrant up
	info "Application has been deployed"
	info "Access boc using $ vagrant ssh"
	info "Access app on http://localhost:8000"
}

ensure() {
	if ! "$@"; then error "command failed: $*"; fi
}

success() {
	printf "\033[32m%s\033[0m\n" "$1" >&1
}

info() {
	printf "%s\n" "$1" >&1
}

warning() {
	printf "\033[33m%s\033[0m\n" "$1" >&2
}

error() {
	printf "\033[31;1m%s\033[0m\n" "$1" >&2
	exit 1
}

cmd_chk() {
	command -v "$1" >/dev/null 2>&1
}
main "$@" || exit 1
