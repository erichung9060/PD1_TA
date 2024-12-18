HW=$(ls /usr/local/bin | grep -oP '^hw\K[0-9]+' | sort -n | tail -1)

function get_submissions {
    FILE=$1

	File_Dir=$Submission_Dir/$FILE
	if test -d $File_Dir; then rm -r $File_Dir; fi
	mkdir $File_Dir

	for id in $(cat /home/cial1/all_students_id.txt); do
		if test -f /home/cial1/Submission_BackUp/${id}/HW${HW}/$FILE.c; then
			cp /home/cial1/Submission_BackUp/${id}/HW${HW}/$FILE.c $File_Dir/${id}.c
		fi
	done
}

Submission_Dir=/home/cial1/Moss/Submissions
if test -d $Submission_Dir; then rm -r $Submission_Dir; fi
mkdir $Submission_Dir

problem=$(ls /share/HW${HW}_TC)
for p in $problem; do
	get_submissions $p
done
chown -R cial1:cial1 $Submission_Dir

cd /home/cial1/Moss
python3 moss.py $problem
