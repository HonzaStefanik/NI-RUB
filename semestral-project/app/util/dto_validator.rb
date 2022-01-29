class DtoValidator
  class << self
    def validate_dto(dto_type, to_validate)
      dto = dto_type.new
      result = dto.call(to_validate)
      return result.to_h if result.success?
      raise ArgumentError.new("Invalid request body #{result.errors.to_h}")
    end
  end
end