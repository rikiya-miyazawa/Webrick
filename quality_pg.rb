# pgライブラリを使用する
require 'pg'

# PG::connect(dbname: "goya")により、rubyからgoyaDBに接続し
# 接続したという情報をconnectionという名前の変数に格納する
connection = PG::connect(dbname: "goya")
connection.internal_encoding = "UTF-8"
begin
  # connection変数を使いPostgreSQLを操作する
  # .execで、goyaDBに"select weight, give_for from crops;"
  # のSQLの命令文を直接実行し、その結果をresult変数に格納する
  qualit = connection.exec("select * from crops where quality = false;")

  # 取り出した各行を処理する
  qualit.each do |quali|
      # 各行を取り出し、putsでターミナル上に出力する
      puts "品質の悪いゴーヤ：#{quali["quality"]}"
  end
ensure
  # 最後に.finishでデータベースへのコネクションを切断する
  connection.finish
end