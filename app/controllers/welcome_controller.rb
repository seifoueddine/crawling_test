class WelcomeController < ApplicationController

  require 'nokogiri'
  require 'open-uri'
  def urls 
    articles_url_autobip = []
    doc = Nokogiri::HTML(URI.open('https://www.autobip.com/fr/actualite/1'))
      doc.css('div.post__text a').map do |link|
        articles_url_autobip << link['href'] if link['itemprop'] == 'url'
      end
      render json: { urls: articles_url_autobip } 
  end
 

  def index
    # url_media_array = params[:urls]
    # articles_url_autobip = []
    # last_dates = []
    # url_media_array.map do |url|
    #   doc = Nokogiri::HTML(URI.open(url))
    #   doc.css('div.post__text a').map do |link|
    #     articles_url_autobip << link['href'] if link['itemprop'] == 'url'
    #   end
    #   # doc.css('div.post__meta.pt-2 time span').map do |date|
    #   #   last_dates << date.text
    #   # end
    # end
    # articles_url_autobip = articles_url_autobip.reject(&:nil?)
    # # last_dates = last_dates.uniq
    # # last_articles = Article.where(medium_id: @media.id).where(date_published: last_dates )
    # # list_articles_url = []
    # # last_articles.map do |article|
    # #   list_articles_url << article.url_article
    # # end
    # # articles_url_autobip_after_check = articles_url_autobip - list_articles_url
 
      article = Nokogiri::HTML(URI.open(URI.escape('https://www.autobip.com/fr/actualite/sav_nouveau_total_quartz_auto_service_a_l_est_d_alger/16894')))
      # new_article = Article.new
     # url_article = link
      # medium_id = @media.id
      category_article = article.css('header.single-header a.cat-theme-bg').text
      title = article.css('h1.entry-title').text

      # author_exist = Author.where(['lower(name) like ? ',
      #                              article.at("//a[@itemprop = 'author']").text.downcase ])
      # new_author = Author.new
      # if author_exist.count.zero?

      author_name = article.at("//a[@itemprop = 'author']").text
      #   new_author.save!
      # else

      #   new_author.id = author_exist.first.id
      #   new_author.name = author_exist.first.name
      # end

      # new_article.author_id = new_author.id
      body = article.css('div.pt-4.bp-2.entry-content.typography-copy').inner_html
      date_published = article.at("//span[@itemprop = 'datePublished']").text
      url_array = article.css('.fotorama.mnmd-gallery-slider.mnmd-post-media-wide img').map { |link| link['src'] }
      url_image = url_array[0]
      tags_array = article.css('a.post-tag').map(&:text)
      # new_article.media_tags = tags_array.join(',')
      
     # tag_check_and_save(tags_array)
    

    render json: { title: title, category_article: category_article ,author_name: author_name, body: body,  date_published: date_published , url_image: url_image, tags_array: tags_array }
  end
end

