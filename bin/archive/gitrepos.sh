touch ~/migration/gitrepos.txt
for i in $(find ~/workspace -maxdepth 2 -type d)
do
  cd "$i"
  if [ -d ".git" ]; then
    echo "${PWD##*/} " >> ~/migration/gitrepos.txt
    git remote get-url origin 2>&1 | tee -a ~/migration/gitrepos.txt
    echo $'\n' >> ~/migration/gitrepos.txt
  fi

done
