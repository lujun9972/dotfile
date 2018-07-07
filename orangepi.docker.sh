echo 0 > sudo tee /proc/sys/kernel/randomize_va_space
for c in emacs-aarch64.docker
do
	docker build -t "lujun9972/${c}" https://github.com/lujun9972/${c}.git
done
echo 1 > sudo tee /proc/sys/kernel/randomize_va_space
