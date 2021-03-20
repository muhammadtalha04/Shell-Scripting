#!/bin/bash
addSpaces()
{
    len=$1
    loop_i=0
    while [[ $loop_i -lt $len ]]; do
        echo -n " "
        loop_i=$((loop_i + 1))
    done
}

if [[ $# -gt 2 ]]; then 
    echo "Too many arguments given"
    exit 0
elif [[ $# -lt 2 ]]; then
    echo "Less arguments given"
    exit 0 
fi

if [[ $1 != left && $1 != right && $1 != full ]]; then
    echo "Please enter a valid pattern option."
    exit 0
fi

if [[ $2 -lt 0 ]]; then
    echo "Please enter a positive integer"
    exit 0
fi

if [[ $1 == left ]]; then
    i=0
    
    while [[ $i -lt $2 ]]; do 
        j=0
        
        while [[ $j -le $i ]]; do
            echo -n "*"
            j=$((j+1))
        done

        echo ""
        i=$((i+1))
    done

    i=$((i-1))
    
    while [[ $i -gt 0 ]]; do
        j=0
    
        while [[ $j -lt $i ]]; do
            echo -n "*"
            j=$((j+1))
        done
    
        echo ""
        i=$((i-1))
    done

elif [[ $1 == right ]]; then
    i=0
    
    while [[ $i -lt $2 ]]; do 
        j=0
        
        addSpaces $((203-i))
        while [[ $j -le $i ]]; do
            echo -n "*"
            j=$((j+1))
        done

        echo ""
        i=$((i+1))
    done

    i=$((i-1))
    
    while [[ $i -gt 0 ]]; do
        j=0
    
        addSpaces $((204-i))
        while [[ $j -lt $i ]]; do
            echo -n "*"
            j=$((j+1))
        done
    
        echo ""
        i=$((i-1))
    done

elif [[ $1 == full ]]; then
    i=0
    
    while [[ $i -lt $2 ]]; do 
        j=0
        
        addSpaces $((101-i))
        while [[ $j -le $((i+i)) ]]; do
            echo -n "*"
            j=$((j+1))
        done

        echo ""
        i=$((i+1))
    done

    i=$((i-1))
    
    while [[ $i -gt 0 ]]; do
        j=0
    
        addSpaces $((102-i))
        while [[ $j -lt $((i+i-1)) ]]; do
            echo -n "*"
            j=$((j+1))
        done
    
        echo ""
        i=$((i-1))
    done
fi

exit