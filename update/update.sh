
exec >&${LOGFD}
exec 2>&${LOGFD}

echo child pid: $$
echo dir: $(pwd)
echo files: "$@"

git checkout master
git pull origin master
git subrepo foreach git pull

for file in "$@"; do
	$(dirname $0)/freshpush $(pwd)/$file
done
