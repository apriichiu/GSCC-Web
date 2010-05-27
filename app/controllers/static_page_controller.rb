class StaticPageController < ApplicationController
  @@pages = { 'Home' => [],
              'About Us'    => [ 'Welcome from the Pastor',
                                 'Vision & Values',
                                 'Our Beliefs',
                                 'Staff' ],
               'Connect'    => [ 'Kids',
                                 'College Students',
                                 'Young Adults',
                                 'Family' ],
               'Serve'     => [ 'Art'],
               'Give'       => [ 'Compassion Ministry',
                                 'Serve the Church' ],
               'Resources'  => [ 'Sermons',
                                 'Calendar of Events',
                                 'Church Blog' ]
            }

  @@page_slugs = Hash.new
  @@pages.each { |section, subsections|
    @@page_slugs[section.dehumanize] = subsections.map(&:dehumanize)
  }
  puts @@page_slugs.inspect

  def self.pages
    return @@pages
  end

  def frontpage
    self.page_title = ''
    render(:frontpage)
  end

  def section
    if @@page_slugs.include?(params[:section])
      self.page_title = params[:section].humanize
      render :action => "#{params[:section]}/index"
    else
      page_not_found!
    end
  end

  def section_page
    if @@page_slugs.include?(params[:section]) and @@page_slugs[params[:section]].include?(params[:subsection])
      self.page_title = "#{params[:subsection].humanize} < #{params[:section].humanize}"
      render :action => "#{params[:section]}/#{params[:subsection]}"
    else
      page_not_found!
    end
  end
end
