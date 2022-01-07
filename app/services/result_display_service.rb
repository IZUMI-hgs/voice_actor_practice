class ResultDisplayService
  
  def initialize(result)
    @result = result
  end
  
  def call
    if result.score.ceil(2) == 0 && result.quote.emotion == "sad"
      {
        score: result.created_at.strftime("%S")[1].to_i*3.09,
        message: "もっと感情を出すことができるはず！殻を破って演技に全力投球してみて下さい！\nヒント：演技の方向性を変える事で判定結果が変わる場合があります。\n例:怒鳴る演技→声は小さいけど怒りをにじませる演技など・・"
      }
    elsif result.score.ceil(2) == 0 && result.quote.emotion == "happy"
      {
        score: result.created_at.strftime("%S")[1].to_i*3.09,
        message: "もっと感情を出すことができるはず！殻を破って演技に全力投球してみて下さい！\nヒント：演技の方向性を変える事で判定結果が変わる場合があります。\n例:怒鳴る演技→声は小さいけど怒りをにじませる演技など・・"
      }
    elsif result.score.ceil(2) == 0
      {
        score: result.created_at.strftime("%S")[1].to_i*1.6,
        message: "もっと感情を出すことができるはず！殻を破って演技に全力投球してみて下さい！\nヒント：演技の方向性を変える事で判定結果が変わる場合があります。\n例:怒鳴る演技→声は小さいけど怒りをにじませる演技など・・"
      }
    elsif result.score.ceil(2) < 1 && result.quote.emotion == "sad"
      {
        score: result.score*36,
        message: "もっと感情を出すことができるはず！殻を破って演技に全力投球してみて下さい！\nヒント：演技の方向性を変える事で判定結果が変わる場合があります。\n例:泣き喚く演技→悲しみを堪えるような演技など・・"
      }
    elsif result.score.ceil(2) < 1 && result.quote.emotion == "happy"
      {
        score: result.score*36,
        message: "もっと感情を出すことができるはず！殻を破って演技に全力投球してみて下さい！\nヒント：演技の方向性を変える事で判定結果が変わる場合があります。\n例:泣き喚く演技→悲しみを堪えるような演技など・・"
      }
    elsif result.score.ceil(2) < 1
      {
        score: result.score*16,
        message: "もっと感情を出すことができるはず！殻を破って演技に全力投球してみて下さい！\nヒント：演技の方向性を変える事で判定結果が変わる場合があります。\n例:泣き喚く演技→悲しみを堪えるような演技など・・"
      }
    elsif result.score.ceil(2)>= 1 && @result.score.ceil(2) < 10 && @result.quote.emotion == "sad"
      {
        score: result.score*7,
        message: "感情が出てきています！\nとても良いですね！引き続きチャレンジしてみて下さい！"
      }
    elsif result.score.ceil(2)>= 1 && @result.score.ceil(2) < 10 && @result.quote.emotion == "happy"
      {
        score: result.score*7,
        message: "感情が出てきています！\nとても良いですね！引き続きチャレンジしてみて下さい！"
      }
    elsif result.score.ceil(2)>= 1 && @result.score.ceil(2) < 10
      {
        score: result.score*3,
        message: "感情が出てきています！\n次はもう少し大げさに演じてみてください！もっと出せます！"
      }
    elsif result.score.ceil(2)>= 10 && @result.score.ceil(2) < 70 && @result.quote.emotion == "sad"
      {
        score: result.score+15,
        message: "なかなか良い表現ですね！\n感情が良く出ています！あと一歩で高得点が狙えそうです！"
      }
    elsif result.score.ceil(2)>= 10 && @result.score.ceil(2) < 70 && @result.quote.emotion == "happy"
      {
        score: result.score+15,
        message: "なかなか良い表現ですね！\n感情が良く出ています！あと一歩で高得点が狙えそうです！"
      }
    elsif result.score.ceil(2)>= 10 && @result.score.ceil(2) < 40
      {
        score: result.score,
        message: "感情が出ています！\n良い感じです、でもまだまだ伸びしろがありますね！ぜひ再チャレンジしてみて下さい！"
      }
    elsif result.score.ceil(2)>= 40 && @result.score.ceil(2) < 70
      {
        score: result.score,
        message: "感情が良く出ています！素晴らしい！\n高得点まであと一歩です！"
      }
    elsif result.score.ceil(2)>= 70 && @result.score.ceil(2) < 85
      {
        score: result.score,
        message: "素晴らしい感情表現です！\n現役の声優ですか！?現役でないなら今すぐ声優養成所に通ってみては・・？"
      }
    else
        {
        score: result.score,
        message: "ぎゃふん！\nまさかこんなに高得点が出せるとは・・難易度高めに作った製作者もびっくりです！"
      }
    end
  end
  
  private
  
  attr_reader :result
  
end