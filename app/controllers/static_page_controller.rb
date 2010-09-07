class StaticPageController < ApplicationController
  @@pages = { 'Home' => [],
              'About Us'    => [ 'Welcome from the Pastor',
                                 'Vision & Values',
                                 'Our Beliefs',
                                 'Staff' ],
               'Connect'    => [ 'Community Groups',
                                 'Worship Service',
                                 'Children\'s Program'],
               'Serve'     => [ 'Worship & Multimedia',
                                'Children',
                                'Outreach'],
               'Give'       => [ 'Compassion and Justice',
                                 'Support GSCC' ],
               'Resources'  => [ 'Sermons',
                                 'Calendar of Events',
                                 'Forms' ],
               'Groups'     => [ 'Antioch',
                                 'Caleb',
                                 'Galilee',
                                 'Genesis',
                                 'Joshua',
                                 'Jordan'
                               ], 
               'Plug-ins'   => ['Student',
                                'Young Adult', 
                                'Family',
                                'International'
                                ],
               'Sermons'   => ['The Promise',
                               'One Body'
                              ]

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
      if params[:section] == "groups"
         render :action => "connect/community_groups"
      elsif params[:section] == "sermons"
        render :action => "resources/sermons"
      else
        self.page_title = params[:section].humanize
        render :action => "#{params[:section]}/index"
      end
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
