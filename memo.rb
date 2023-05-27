require "csv" # CSVファイルを扱うためのライブラリを読み込む

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する" #選択肢を表示
memo_type = gets.chomp.to_s # ユーザー入力値を文字列へ変換
puts "選択：" + memo_type # 選択した番号を表示
input_number = memo_type.chomp # 改行を削除するchompメソッド

if input_number == "1" # 以下に１を選択した場合の処理を記述
  puts "新規でメモを作成します。拡張子を除いたファイル名を入力してください。"
  file_name = gets.chomp

  puts "メモの内容を記入して下さい。Ctrl+Dで保存します。"
  input_memo = STDIN.read # キーボードへの入力がターミナルに表示、それを読取る
  memo = input_memo.chomp

  CSV.open("#{file_name}.csv", "w") do |csv|
    csv << [memo]
  end

elsif input_number == "2" # 以下に2を選択した場合の処理を記述
  puts "既存のメモを編集します。拡張子を除いた既存ファイル名を入力してください。"
  file_name = gets.chomp

  puts "以下のメモがあります。"
  CSV.foreach("#{file_name}.csv") do |row| # CSVファイルから１行ずつ読み取る
    puts row[0]
  end

  puts "編集するメモの番号を入力してください。"
  memo_number = gets.chomp.to_i # ユーザー入力値を数値へ変換

  memo_list = []
  CSV.foreach("#{file_name}.csv") do |row|
    memo_list << row[0]
  end

  if memo_number > 0 && memo_number <= memo_list.length
    puts "選択されたメモを編集してください。Ctrl+Dで保存します。"
    input_memo = STDIN.read
    memo = input_memo.chomp

    memo_list[memo_number - 1] = memo

    CSV.open("#{file_name}.csv", "w") do |csv|
      memo_list.each do |memo|
        csv << [memo]
      end
    end

    puts "メモを更新しました。"
  else
    puts "不正な入力です。"
  end

else
  puts "1か2の数字を入力してください"
end