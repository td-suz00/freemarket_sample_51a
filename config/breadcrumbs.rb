crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", user_path(current_user)
  parent :root
end

crumb :cards_index do
  link "支払い方法", user_cards_path(current_user)
  parent :mypage
end

crumb :cards_add do
  link "クレジットカード情報入力", new_user_card_path(current_user)
  parent :cards_index
end

crumb :logout do
  link "ログアウト", new_user_logout_path(current_user)
  parent :mypage
end

crumb :profile do
  link "プロフィール", edit_user_user_profile_path(current_user, 1)
  parent :mypage
end

crumb :user_confirmation do
  link "本人情報の登録", edit_user_user_confirmation_path(current_user, 1)
  parent :mypage
end

crumb :item do |item|
  link item.name, item_path(item)
  parent :root
end

crumb :searched_items do |keyword|
  link keyword, search_items_path
end

crumb :categories do
  link "カテゴリー一覧", categories_path(current_user)
  parent :root
end

#### 以下はビュー作成次第対応予定
# カテゴリ一覧
# 親カテゴリ
# 子カテゴリ
# 孫カテゴリ
# ブランド一覧
# 各ブランド