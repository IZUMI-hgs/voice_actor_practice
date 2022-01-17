module ApplicationHelper
  def default_meta_tags
    {
      site: 'voice-actor-practice',
      title: '声優セリフ練習アプリ',
      reverse: true,
      separator: '|',
      description: 'ひとりでも掛け合いが練習できるアプリ。',
      keywords: '声優',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: image_url('logo_ogp.jpeg') },
        { href: image_url('logo_ogp.jpeg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpeg' }
      ],
      og: {
        site_name: 'voice-actor-practice',
        title: '声優セリフ練習アプリ',
        description: 'ひとりでも掛け合いが練習できるアプリ。',
        type: 'website',
        url: request.original_url,
        image: image_url('logo_ogp.jpeg'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary',
        site: '@izumi60173364'
      }
    }
  end
end
