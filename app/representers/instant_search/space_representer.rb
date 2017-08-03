# -*- encoding : utf-8 -*-
module InstantSearch
  module SpaceRepresenter
    include ROAR::JSON
    include ROAR::Feature::Hypermedia

    property :id
    property :name
    property :thumbnail
    property :type
    property :legend

    link :slef_public do
      url_for(self)
    end

    def thumbnail
      self.course.environment.avatar.url(:thumb_32)
    end

    def type
      "environment"
    end

    def legend
      "Disciplina — #{self.course.environment.name}"
    end
  end
end
