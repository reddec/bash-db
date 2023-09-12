install:
	@if cp db.sh /usr/local/bin/db 2>/dev/null; then \
		chmod +x /usr/local/bin/db; \
		echo "Copied db.sh to /usr/local/bin/db"; \
	elif echo $$PATH | grep -q "$$(realpath ~/.local/bin)"; then \
		if [ ! -d ~/.local/bin ]; then \
			echo "Creating directory ~/.local/bin"; \
			mkdir -p ~/.local/bin; \
		fi; \
		cp db.sh ~/.local/bin/db; \
		chmod +x ~/.local/bin/db; \
		echo "Copied db.sh to ~/.local/bin/db"; \
	else \
		echo "Current PATH: $$PATH"; \
		echo "Realpath of ~/.local/bin: $$(realpath ~/.local/bin)"; \
		echo "Error: Could not copy db.sh to /usr/local/bin/db and ~/.local/bin is not in PATH."; \
	fi;
