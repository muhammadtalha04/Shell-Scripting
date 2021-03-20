#!/bin/bash

revertPermissions()
{
    num=$1

    if [[ $1 -eq 0 ]]; then
        num=7
    elif [[ $1 -eq 1 ]]; then
        num=6
    elif [[ $1 -eq 2 ]]; then
        num=5
    elif [[ $1 -eq 3 ]]; then
        num=4
    elif [[ $1 -eq 4 ]]; then
        num=3
    elif [[ $1 -eq 5 ]]; then
        num=2
    elif [[ $1 -eq 6 ]]; then
        num=1
    elif [[ $1 -eq 7 ]]; then
        num=0
    fi

    return $num
}


echo -n "" > log.txt

revertPermissions 12

while [[ True ]]; do
    echo "1) Invert the permissions of a file"
    echo "2) Search a string in a file"
    echo "3) Copy first and last N number of lines of all the file in current directory in a file"
    echo "4) Check and change the modified date of a file"
    echo "exit) Exit"
    echo ""

    echo -n ">> "
    read option

    if [[ $option =~ ^[a-zA-Z]*$ ]]; then
        if [[ $option = exit ]]; then
            echo "Option exit" >> log.txt
            echo "Script terminated at "$(date +"%D %T") >> log.txt
            exit
        else
            echo ""
            echo "Invalid option selected"
            echo ""
        fi
    else
        if [[ $option -lt 1 || $option -gt 4 ]]; then
            echo ""
            echo "Invalid option selected"
            echo ""
        else
            echo ""
            
            if [[ $option -eq 1 ]]; then
                read -p "Filename: " filename
                old=$(ls $filename | xargs stat --printf "%A")

                permissions=$(ls $filename | xargs stat --printf "%a")
                
                usr=$((permissions/100))
                permissions=$((permissions%100))
                grp=$((permissions/10))
                other=$((permissions%10))

                revertPermissions $usr
                usr=$?
                revertPermissions $grp
                grp=$?
                revertPermissions $other
                other=$? 

                chmod $usr$grp$other $filename

                new=$(ls $filename | xargs stat --printf "%A")

                echo "Option 01 selected at "$(date +"%D %T") >> log.txt
                echo "Filename: $filename" >> log.txt
                echo "Permissions of $filename: $old" >> log.txt
                echo "Permissions changed" >> log.txt
                echo "Updated Permissions of $filename: $new" >> log.txt
                echo "" >> log.txt
            elif [[ $option -eq 2 ]]; then
                read -p "Filename: " filename
                read -p "String: " string
                echo ""

                for line in $(grep $string $filename); do
                    echo $line
                done

                echo "Option 02 selected at "$(date +"%D %T") >> log.txt
                echo "Filename: $filename" >> log.txt
                echo "String: $string" >> log.txt
                echo "Output all the lines in $filename where $string is found" >> log.txt
                echo "" >> log.txt
            elif [[ $option -eq 3 ]]; then
                echo -n "" > dummy.txt
                read -p "N: " N
                
                i=0
                even=""
                odd=""

                for f in $(ls -I dummy.txt -I log.txt); do
                    if [[ $i -eq 0 ]]; then
                        tail -n $N $f >> dummy.txt
                        i=1
                        odd=$odd" "$f
                    else
                        head -n $N $f >> dummy.txt
                        i=0
                        even=$even" "$f
                    fi

                    echo "" >> dummy.txt
                done

                echo "Option 03 selected at "$(date +"%D %T") >> log.txt
                echo "Files at odd location: $odd" >> log.txt
                echo "Files at even location: $even" >> log.txt
                echo "Dummy.txt is created and $N lines of each file copied in it" >> log.txt
                echo "" >> log.txt
            elif [[ $option -eq 4 ]]; then
                read -p "Filename: " filename
                oldTime=$(date -r $filename +%D\ %T)

                orig=$(date -r $filename +%s)
                now=$(date +%s)
                file_age=$((now - orig))

                if [[ $file_age -ge 86400 ]]; then
                    echo ""
                    echo "Changed the modified date of $filename to current date"
                    touch $filename
                fi

                echo "Option 04 selected at "$(date +"%D %T") >> log.txt
                echo "Filename: $filename" >> log.txt
                echo "Current modified date: $oldTime" >> log.txt
                echo $(date -r $filename +%D\ %T) >> log.txt
                echo "" >> log.txt
            fi

            echo ""
        fi
    fi
done