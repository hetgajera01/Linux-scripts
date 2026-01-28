source_dir=$1
timestamp=$(date '+%Y-%m-%H-%M-%S')
backup_dir=$2

create_backup() {
	zip -r ${backup_dir}/backup_${timestamp} ${source_dir}
}
if [[ $# == 2 ]]; then
	create_backup
fi
