desc "モンタージュ画像の生成"
task :create_montage do
  if Pathname("doc/images").exist?
    `montage -tile 2 -thumbnail 800x -geometry +0+0 doc/images/*.png montage.png`
    `montage -tile 3 -thumbnail 400x -geometry +0+0 doc/images/*.png montage_for_doc.png`
    system "tree -N doc"
    system "ls -al montage*"
    system "open montage.png"
  end
end

# rake db_sync TABLES=xy_records
desc "本番サーバーの production の DB をローカルの development にコピーする (オプション: TABLES=t1,t2,t3)"
task :db_sync do
  Rake::Task[:production_db_backup_to_local].invoke
  system "gzip -d db/shogi_web_production.sql.gz"
  system "mysql -u root shogi_web_development < db/shogi_web_production.sql"
end

desc "本番サーバーの production の DB をローカルにバックアップする"
task :production_db_backup_to_local do
  tables = (ENV["TABLES"] || "").split(",").join(" ")
  system "ssh i mysqldump -u root -i --add-drop-table shogi_web_production #{tables} --single-transaction --result-file /tmp/shogi_web_production.sql"
  system "ssh i gzip /tmp/shogi_web_production.sql"
  system "scp i:/tmp/shogi_web_production.sql.gz db"
end

desc "DBを新サーバーにコピー"
task :db_copy_to_ishikari do
  p "ローカルに取得"
  Rake::Task[:production_db_backup_to_local].invoke
  p "石狩へ"
  system "scp db/shogi_web_production.sql i:~/"
  p "インポート"
  system "ssh i 'mysql -u root shogi_web_production < ~/shogi_web_production.sql'"
end

desc "shared/storage を新サーバーにコピー"
task :storage_copy_to_ishikari do
  system "scp -r s:/var/www/shogi_web_production/shared/storage db/"
  system "scp -r db/storage i:/var/www/shogi_web_production/shared/"
end

desc "なんかしらのエラー画像の生成"
task :nankasirano_error_image_generate do
  system "convert -background '#fff' -fill '#999' -size 1200x630 -gravity center -font /Library/Fonts/Ricty-Regular.ttf -pointsize 80 label:'なんかしらのエラーです\nたぶん反則です' app/assets/images/fallback.png"
end
