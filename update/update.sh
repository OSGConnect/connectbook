
exec >&${LOGFD}
exec 2>&${LOGFD}

echo child pid: $$
echo dir: $(pwd)
echo files: "$@"

#git checkout master
#git pull origin master
#git submodule foreach git pull origin master

#for file in "$@"; do
#	$(dirname $0)/freshpush $(pwd)/$file
#done

find . -name \*.md -print | while read file; do
	dir=$(dirname "$file")
	upstream=$(cd "$dir"; git config --get remote.origin.url | sed -e 's/.git$//')
	relpath=$(cd "$dir"; git ls-files --full-name $(basename "$file"))
	env "upstream=$upstream" "relpath=$relpath" $(dirname $0)/freshpush $(pwd)/$file
done
