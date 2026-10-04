local DbOption  = require('Options.DbOption')
local i18n	    = require('i18n')

local _ = i18n.ptranslate

return {
    OH6TrimmingMethod	= DbOption.new():setValue(0):combo({DbOption.Item(_('JOYSTICK WITH SPRING/CENTRAL POSITION')):Value(0),
															DbOption.Item(_('JOYSTICK WITH FFB OR WITHOUT SPRINGS')):Value(1),
                                                        }),
    OH6PedalTrim = DbOption.new():setValue(false):checkbox(),
    OH6TrimFade = DbOption.new():setValue(100):slider(DbOption.Range(10, 500)),
    OH6AimingMark = DbOption.new():setValue(false):checkbox(),
    OH6AimingMarkOffset	= DbOption.new():setValue(0):slider(DbOption.Range(-100, 100)),
    OH6CyclicButtonSensitivity	= DbOption.new():setValue(0.15):slider(DbOption.Range(0.05, 5.0)),
    OH6PedalButtonSensitivity	= DbOption.new():setValue(0.15):slider(DbOption.Range(0.05, 5.0)),
    OH6CollectiveButtonSensitivity	= DbOption.new():setValue(0.15):slider(DbOption.Range(0.05, 5.0)),
    OH6ShowControls = DbOption.new():setValue(true):checkbox(),
    OH6ShowCrewStatus = DbOption.new():setValue(true):checkbox(),
}
