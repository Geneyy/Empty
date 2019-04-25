--[[
    @desc:参考的quick-cocos2d
]]

--[[
    @desc: 拷贝对象
]]
function Clone(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

--[[
    @desc: 类定义
]]
function Class(classname, super)
    local cls

    if super then
        cls = Clone(super)
        cls.super = super
    else
        cls = {ctor = function() end}
    end

    cls.super = super
    cls.__cname = classname
    cls.__index = cls

    cls.new = function(...)
        local instance = setmetatable({}, cls)
        instance.class = cls
        instance:ctor(...)
        return instance   
    end

    return cls
end