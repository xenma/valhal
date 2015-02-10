class validy < ActiveModel::Validator
  def validate(record)
    if record.mime_type != "text/xml"
      record.errors[:base] << "This object is not XML"
    else
      record.errors[:base] << "This object is XML"
    end
  end
end
