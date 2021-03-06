<?php 
    $label = Engine_Api::_()->ynresume()->getSectionLabel($this->section);
    $viewer = Engine_Api::_()->user()->getViewer();
    $level_id = 5;
    if ($viewer->getIdentity()) $level_id = $viewer->level_id;
    $resume = (isset($params['view']) && $params['view']) ? Engine_Api::_()->core()->getSubject() : $this->resume;
    $params = $this->params;
    $manage = ($resume->isOwner($viewer)) && (!isset($params['view']) || !$params['view']);
    $create = (isset($params['create'])) ? $params['create'] : false;
    $edit = (isset($params['edit'])) ? $params['edit'] : false;
    $hide = (isset($params['hide'])) ? $params['hide'] : false;
    $business_enable = Engine_Api::_()->hasModuleBootstrap('ynbusinesspages');
    if ($business_enable) {
        $table = Engine_Api::_()->getItemTable('ynbusinesspages_business');
        $select = $table->getBusinessesSelect(array('status' => 'published'));
        $businesses = $table->fetchAll($select);
    }
    $permissionsTable = Engine_Api::_()->getDbtable('permissions', 'authorization');
    $max_photo = $permissionsTable->getAllowed('ynresume_resume', $level_id, 'max_photo');
    if ($max_photo == null) {
        $row = $permissionsTable->fetchRow($permissionsTable->select()
        ->where('level_id = ?', $level_id)
        ->where('type = ?', 'ynresume_resume')
        ->where('name = ?', 'max_photo'));
        if ($row) {
            $max_photo = $row->value;
        }
    }
?>
<?php
$experience = $resume->getAllExperience();
if (count($experience) <= 0 && $manage) {
    $create = true;
}
?>
<?php if (count($experience) > 0 || (!$hide && ($create || $edit))) : ?>
    <?php $label = Engine_Api::_()->ynresume()->getSectionLabel($this->section); ?>
    
    <?php if ($manage) : ?>
        <a class="ynresume-add-btn" rel="<?php echo $this->section;?>"><?php echo $this->translate('Add position')?></a>
    <?php endif; ?>
    
    <h3 class="section-label">
        <span class="section-label-icon"><i class="<?php echo Engine_Api::_()->ynresume()->getSectionIconClass($this->section);?>"></i></span>
        <span><?php echo $label;?></span>
    </h3>
    
    <div class="ynresume_loading" style="display: none; text-align: center">
        <img src='application/modules/Ynresume/externals/images/loading.gif'/>
    </div>
    
    <div class="ynresume-section-content">
    <?php if ($manage) : ?>
        <?php if (!$hide && ($create || $edit)) : ?>
        <?php $this->headScript()->appendFile("//maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"); ?>
        <div id="ynresume-section-form-experience" class="ynresume-section-form">
            <form rel="experience" class="section-form" enctype="multipart/form-data">
                <p class="error"></p>
                <?php $item = null;?>
                <?php if ($edit && isset($params['item_id'])) : ?>
                <?php $item = Engine_Api::_()->getItem('ynresume_experience', $params['item_id']);?>
                <input type="hidden" name="item_id" class="item_id" id="experience-<?php echo $item->getIdentity()?>" value=<?php echo $item->getIdentity()?> />
                <?php endif; ?>
                <div id="experience-title-wrapper" class="ynresume-form-wrapper">
                    <label for="experience-title"><?php echo $this->translate('*Title')?></label>
                    <div class="ynresume-form-input">
                        <input type="text" id="experience-title" name="title" value="<?php if ($item) echo htmlentities($item->title);?>"/>
                        <p class="error"></p>
                    </div>
                </div>
                <div id="experience-company-wrapper" class="ynresume-form-wrapper">                
                    <label for="experience-company"><?php echo $this->translate('*Company Name')?></label>
                    <div class="ynresume-form-input ynresume-form-input-awesomplete">
                        <?php if ($edit && $item && $item->business_id) : ?>
                            <?php $business = ($business_enable) ? Engine_Api::_()->getItem('ynbusinesspages_business', $item->business_id) : null;?>
                            <input type="text" id="experience-company" autocomplete="off" name="company" value="<?php echo ($business && !$business->deleted) ? $business->getTitle() : $item->company;?>"/>
                        <?php else: ?>
                            <input type="text" id="experience-company" autocomplete="off" name="company" value="<?php if ($item) echo htmlentities($item->company);?>"/>
                        <?php endif;?>

                        <?php if ($business_enable && count($businesses)) : ?>
                            <input type="hidden" id="experience-business_id" name="business_id" value="<?php if ($item) echo $item->business_id?>"/>
                        <?php endif; ?>
                        <p class="error"></p>
                    </div>
                </div>
                <div id="experience-time_period-wrapper" class="ynresume-form-wrapper">                
                    <label><?php echo $this->translate('*Time Period')?></label>
                    <div class="ynresume-form-input ynresume-form-input-4item">
                        <div class="">
                            <select name="start_month" id="experience-start_month" value="<?php if ($item) echo $item->start_month?>">
                                <?php $month = array('Choose...', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')?>
                                <?php foreach ($month as $key => $value) : ?>
                                <option value="<?php echo $key?>" <?php if ($item && $item->start_month == $key) echo 'selected';?>><?php echo $this->translate($value)?></option>
                                <?php endforeach; ?>
                            </select>
                            <input type="text" name="start_year" id="experience-start_year" value="<?php if ($item) echo $item->start_year?>"/>
                             - 
                            <select name="end_month" id="experience-end_month">
                                <?php foreach ($month as $key => $value) : ?>
                                <option value="<?php echo $key?>" <?php if ($item && $item->end_month == $key) echo 'selected';?>><?php echo $this->translate($value)?></option>
                                <?php endforeach; ?>
                            </select>
                            <input type="text" name="end_year" id="experience-end_year" value="<?php if ($item) echo $item->end_year?>"/>
                            <label id="experience-present"><?php echo $this->translate('Present')?></label>
                        </div>
                        <div class="ynresume-form-input-checkbox">
                            <input type="checkbox" id="experience-current" name="current" value="1" <?php if ($item && !$item->end_year) echo 'checked'?>/>
                            <label for="experience-current"><?php echo $this->translate('I currently work here')?></label>
                        </div>
                        <p class="error"></p>
                    </div>
                </div>
                <div id="experience-location-wrapper" class="ynresume-form-wrapper">
                    <label for="experience-location"><?php echo $this->translate('Location')?></label>
                    <div class="ynresume-form-input ynresume-form-input-map">
                        <input type="text" id="experience-location" name="location" value="<?php if ($item) echo $item->location?>"/>
                        <a class='ynresume_location_icon' href="javascript:void(0)" id='experience-get-current-location'>
                            <img src="<?php echo $this -> baseUrl();?>/application/modules/Ynresume/externals/images/icon-search-advform.png">
                        </a>
                        <input type="hidden" id="experience-longitude" name="longitude" value="<?php if ($item) echo $item->longitude?>"/>
                        <input type="hidden" id="experience-latitude" name="latitude" value="<?php if ($item) echo $item->latitude?>"/>
                        <p class="error"></p>
                    </div>
                </div>
                <div id="experience-description-wrapper" class="ynresume-form-wrapper">
                    <label for="experience-description"><?php echo $this->translate('Description')?></label>
                    <div class="ynresume-form-input">
                        <textarea id="experience-description" name="description"/><?php if ($item) echo $item->description?></textarea>
                        <p class="error"></p>
                    </div>
                </div>
                <div id="experience-photos-wrapper" class="ynresume-form-wrapper upload-photos-wrapper">                
                    <label><?php echo $this->translate('Add photos')?></label>
                    <div class="ynresume-form-input">
                        <div id="file-wrapper">
                            <div class="form-element">
                                <!-- The fileinput-button span is used to style the file input field as button -->
                                <p class="element-description"><?php echo $this->translate(array('add_photo_description', 'You can add up to %s photos', $max_photo), $max_photo)?></p>
                                <span class="btn fileinput-button btn-success" type="button">
                                    <i class="glyphicon glyphicon-plus"></i>
                                    <span><?php echo $this->translate("Add Photos")?></span>
                                    <!-- The file input field used as target for the file upload widget -->
                                    <input class="section-fileupload" id="experience-fileupload" type="file" accept="image/*" name="files[]" multiple>
                                </span>
                                <button type="button" class="btn btn-danger delete" onclick="clearList(this)">
                                    <i class="glyphicon glyphicon-trash"></i>
                                    <span><?php echo $this->translate("Clear List")?></span>
                                </button>
                                <br /> 
                                <br />  
                                
                                <!-- The global progress bar -->
                                <div id="progress" class="progress" style="display: none; width: 400px; float:left">
                                    <div class="progress-bar progress-bar-success"></div>
                                </div>
                                <span id="progress-percent"></span>
                                <!-- The container for the uploaded files -->
                                <?php $upload_photos = ($item) ? Engine_Api::_()->getItemTable('ynresume_photo')->getPhotosItem($item) : array();?>
                                <?php $photos = array()?>
                                <ul id="files" class="files" style="<?php if (count($upload_photos)) echo 'display:block;'?>">
                                <?php foreach ($upload_photos as $photo) : ?>
                                    <li class="file-success">
                                        <a class="file-remove" onclick="removeFile(this, <?php echo $photo->getIdentity()?>)" href="javascript:;" title="<?php echo $this->translate('Click to remove this entry.')?>">Remove</a>
                                        <span class="file-name"><?php echo $photo->title?></span>
                                    </li>
                                <?php $photos[] = $photo->getIdentity();?>
                                <?php endforeach;?>
                                </ul>
                                <input type="hidden" class="upload-photos" name="photo_ids" value="<?php echo implode(' ', $photos)?>"/>
                            </div>
                        </div>
                        <p class="error"></p>
                    </div>
                </div>
                <div class="ynresume-form-buttons ynresume-form-wrapper">
                    <label></label>
                    <div class="ynresume-form-input">
                        <button type="submit" id="submit-btn"><?php echo $this->translate('Save')?></button>
                        <button type="button" class="ynresume-cancel-btn"><?php echo $this->translate('Cancel')?></button>
                        <?php if ($edit && isset($params['item_id'])) : ?>
                        <?php echo $this->translate(' or ')?>
                        <a href="javascript:void(0);" class="ynresume-remove-btn"><?php echo $this->translate('Remove position')?></a>
                        <?php endif; ?>
                    </div>                
                </div>            
            </form>
        </div>
        <script type="text/javascript">
            //add event for form
            window.addEvent('domready', function() {
                var current = $('experience-current');
                if (current) {
                    if (current.checked) {
                        $('experience-end_month').hide();
                        $('experience-end_year').hide();
                    }
                    else {
                        $('experience-present').hide();
                    }
                    
                    current.addEvent('change', function() {
                        if (current.checked) {
                            $('experience-end_month').hide();
                            $('experience-end_year').hide();
                            $('experience-present').show();
                        }
                        else {
                            $('experience-present').hide();
                            $('experience-end_month').show();
                            $('experience-end_year').show();
                        }
                    });
                    
                    $('experience-get-current-location').addEvent('click', function(){
                        getCurrentLocation();   
                    });
                    
                    initialize();
                    google.maps.event.addDomListener(window, 'load', initialize); 
                }
            });
            
            function initialize() {
                var input = /** @type {HTMLInputElement} */(
                    document.getElementById('experience-location'));
            
                var autocomplete = new google.maps.places.Autocomplete(input);
            
                google.maps.event.addListener(autocomplete, 'place_changed', function() {
                    var place = autocomplete.getPlace();
                    if (!place.geometry) {
                        return;
                    }
                    document.getElementById('experience-latitude').value = place.geometry.location.lat();     
                    document.getElementById('experience-longitude').value = place.geometry.location.lng();
                });
            }
          
            function getCurrentLocation () {   
                if(navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(function(position) {
                    var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                    if(pos){
                        current_posstion = new Request.JSON({
                            'format' : 'json',
                            'url' : '<?php echo $this->url(array('action'=>'get-my-location'), 'ynresume_general') ?>',
                            'data' : {
                                latitude : pos.lat(),
                                longitude : pos.lng(),
                            },
                            'onSuccess' : function(json, text) {
                                if(json.status == 'OK') {
                                    document.getElementById('experience-location').value = json.results[0].formatted_address;
                                    document.getElementById('experience-latitude').value = json.results[0].geometry.location.lat;     
                                    document.getElementById('experience-longitude').value = json.results[0].geometry.location.lng;        
                                }
                                else {
                                    handleNoGeolocation(true);
                                }
                            }
                        }); 
                        current_posstion.send();
                    }
                    }, function() {
                        handleNoGeolocation(true);
                    });
                }
                else {
                    // Browser doesn't support Geolocation
                    handleNoGeolocation(false);
                }
                return false;
            }
            
            function handleNoGeolocation(errorFlag) {
                if (errorFlag) {
                    document.getElementById('experience-location').value = 'Error: The Geolocation service failed.';
                } 
                else {
                    document.getElementById('experience-location').value = 'Error: Your browser doesn\'t support geolocation.';
                }
            }
        </script>
        
        <?php if ($business_enable && count($businesses)) : ?>
        <script type="text/javascript">
        //script for autocomplete business
            var business_id = [];
            var business_name = [];
            <?php foreach ($businesses as $business) : ?>
            business_id.push(<?php echo $business->getIdentity();?>);
            <?php $business_title = $business->getTitle(); ?>
            business_name.push('<?php echo htmlspecialchars("$business_title", ENT_QUOTES);?>');
            <?php endforeach; ?>
            (function () {
                function $(expr, con) {
                    if (!expr) return null;
                    return typeof expr === 'string'? (con || document).querySelector(expr) : expr;
                }
                
                function $$(expr, con) {
                    return Array.prototype.slice.call((con || document).querySelectorAll(expr));
                }
                
                $.create = function(tag, o) {
                    var element = document.createElement(tag);
                    
                    for (var i in o) {
                        var val = o[i];
                        
                        if (i == "inside") {
                            $(val).appendChild(element);
                        }
                        else if (i == "around") {
                            var ref = $(val);
                            ref.parentNode.insertBefore(element, ref);
                            element.appendChild(ref);
                        }
                        else if (i in element) {
                            element[i] = val;
                        }
                        else {
                            element.setAttribute(i, val);
                        }
                    }
                    
                    return element;
                };
                
                $.bind = function(element, o) {
                    if (element) {
                        for (var event in o) {
                            var callback = o[event];
                            
                            event.split(/\s+/).forEach(function (event) {
                                element.addEventListener(event, callback);
                            });
                        }
                    }
                };
                
                $.fire = function(target, type, properties) {
                    var evt = document.createEvent("HTMLEvents");
                            
                    evt.initEvent(type, true, true );
                
                    for (var j in properties) {
                        evt[j] = properties[j];
                    }
                
                    target.dispatchEvent(evt);
                };
                
                var _ = self.Awesomplete = function (input, o) {
                    var me = this;
                    
                    // Setup environment
                    o = o || {};
                    
                    this.input = input;
                    input.setAttribute("aria-autocomplete", "list");
                    
                    this.minChars = +input.getAttribute("data-minchars") || o.minChars || 1;
                    this.maxItems = +input.getAttribute("data-maxitems") || o.maxItems || 100;
                    
                    if (input.hasAttribute("list")) {
                        this.list = "#" + input.getAttribute("list");
                        input.removeAttribute("list");
                    }
                    else {
                        this.list = input.getAttribute("data-list") || o.list || [];
                    }
                    this.filter = o.filter || _.FILTER_CONTAINS;
                    this.sort = o.sort || _.SORT_BYLENGTH;
                    
                    this.autoFirst = input.hasAttribute("data-autofirst") || o.autoFirst || false;
                    
                    this.item = o.item || function (text, input) {
                        return $.create("li", {
                            innerHTML: text.replace(RegExp(regEscape(input.trim()), "gi"), "<mark>$&</mark>"),
                            "aria-selected": "false"
                        }); 
                    };
                    
                    this.index = -1;
                    
                    this.container = $.create("div", {
                        className: "awesomplete",
                        around: input
                    });
                    
                    this.ul = $.create("ul", {
                        hidden: "",
                        inside: this.container
                    });
                    
                    // Bind events
                    
                    $.bind(this.input, {
                        "input": function () {
                            me.evaluate();
                        },
                        "blur": function () {
                            me.close();
                        },
                        "keydown": function(evt) {
                            var c = evt.keyCode;
                            
                            if (c == 13 && me.index > -1) { // Enter
                                evt.preventDefault();
                                me.select();
                            }
                            else if (c == 27) { // Esc
                                me.close();
                            }
                            else if (c == 38 || c == 40) { // Down/Up arrow
                                evt.preventDefault();
                                me[c == 38? "previous" : "next"]();
                            }
                        }
                    });
                    
                    $.bind(this.input.form, {"submit": function(event) {
                        me.close();
                    }});
                    
                    $.bind(this.ul, {"mousedown": function(evt) {
                        var li = evt.target;
                        
                        if (li != this) {
                            
                            while (li && !/li/i.test(li.nodeName)) {
                                li = li.parentNode;
                            }
                            
                            if (li) {
                                me.select(li);  
                            }
                        }
                    }});
                };
                
                _.prototype = {
                    set list(list) {
                        if (Array.isArray(list)) {
                            this._list = list;
                        }
                        else {
                            if (typeof list == "string" && list.indexOf(",") > -1) {
                                this._list = list.split(/\s*,\s*/);
                            }
                            else {
                                list = $(list);
                                if (list && list.children) {
                                    this._list = [].slice.apply(list.children).map(function (el) {
                                        return el.innerHTML.trim();
                                    });
                                }
                            }
                        }
                    },
                    
                    close: function () {
                        this.ul.setAttribute("hidden", "");
                        this.index = -1;
                        
                        $.fire(this.input, "awesomplete-close");
                    },
                    
                    open: function () {
                        this.ul.removeAttribute("hidden");
                        
                        if (this.autoFirst && this.index == -1) {
                            this.goto(0);
                        }
                        
                        $.fire(this.input, "awesomplete-open");
                    },
                    
                    next: function () {
                        var count = this.ul.children.length;
                
                        this.goto(this.index < count - 1? this.index + 1 : -1);
                    },
                    
                    previous: function () {
                        var count = this.ul.children.length;
                        
                        this.goto(this.index > -1? this.index - 1 : count - 1);
                    },
                    
                    // Should not be used, highlights specific item without any checks!
                    goto: function (i) {
                        var lis = this.ul.children;
                        
                        if (this.index > -1) {
                            lis[this.index].setAttribute("aria-selected", "false");
                        }
                        
                        this.index = i;
                        
                        if (i > -1 && lis.length > 0) {
                            lis[i].setAttribute("aria-selected", "true");
                        }
                    },
                    
                    select: function (selected) {
                        selected = selected || this.ul.children[this.index];
                
                        if (selected) {
                            var prevented;
                            
                            $.fire(this.input, "awesomplete-select", {
                                text: selected.textContent,
                                preventDefault: function () {
                                    prevented = true;
                                }
                            });
                            
                            if (!prevented) {
                                this.input.value = selected.textContent;
                                var index = business_name.indexOf(selected.textContent);
                                document.getElementById('experience-business_id').set('value', business_id[index]);
                                this.close();
                                $.fire(this.input, "awesomplete-selectcomplete");
                            }
                        }
                    },
                    
                    evaluate: function() {
                        var me = this;
                        var value = this.input.value;
                                
                        if (value.length >= this.minChars && this._list.length > 0) {
                            this.index = -1;
                            // Populate list with options that match
                            this.ul.innerHTML = "";
                
                            this._list.filter(function(item) {
                                return me.filter(item, value);
                            })
                            .sort(this.sort)
                            .every(function(text, i) {
                                me.ul.appendChild(me.item(text, value));
                                
                                return i < me.maxItems - 1;
                            });
                            
                            this.open();
                        }
                        else {
                            this.close();
                        }
                    }
                };
                
                _.FILTER_CONTAINS = function (text, input) {
                    return RegExp(regEscape(input.trim()), "i").test(text);
                };
                
                _.FILTER_STARTSWITH = function (text, input) {
                    return RegExp("^" + regEscape(input.trim()), "i").test(text);
                };
                
                _.SORT_BYLENGTH = function (a, b) {
                    if (a.length != b.length) {
                        return a.length - b.length;
                    }
                    
                    return a < b? -1 : 1;
                };
                
                function regEscape(s) { return s.replace(/[-\\^$*+?.()|[\]{}]/g, "\\$&"); }
                
                function init() {
                    $$("input.awesomplete").forEach(function (input) {
                        new Awesomplete(input);
                    });
                }
                
                // DOM already loaded?
                if (document.readyState !== "loading") {
                    init();
                } else {
                    // Wait for it
                    document.addEventListener("DOMContentLoaded", init);
                }
                
                _.$ = $;
                _.$$ = $$;
                
                })();
                
            
            window.addEvent('domready', function() {
                var input = document.getElementById('experience-company');
                if (input) {  
                    new Awesomplete(input, {
                        list: business_name,
                        sort: function() {
                            return;
                        }
                    });
                } 
            });
        </script>
        
        <?php endif;?>
        <?php endif;?>
    <?php endif;?>
    <?php if (count($experience) > 0) : ?>
    <div id="ynresume-section-list-experience" class="ynresume-section-list">
        <ul id="experience-list" class="section-list">
        <?php foreach ($experience as $item) :?>
        <li class="section-item" id="experience-<?php echo $item->getIdentity()?>">
            <div class="sub-section-item">
                <?php 
                    $start_month = ($item->start_month) ? $item->start_month : 1;
                    $start_date = date_create($item->start_year.'-'.$start_month.'-'.'1');
                    if ($item->start_month) {
                        $start_time = date_format($start_date, 'M Y');
                    }
                    else {
                        $start_time = date_format($start_date, 'Y');
                    }
                    if ($item->end_year) {
                        $end_month = ($item->end_month) ? $item->end_month : 1;
                        $end_date = date_create($item->end_year.'-'.$end_month.'-'.'1');
                        if ($item->end_month) {
                            $end_time = date_format($end_date, 'M Y');
                        }
                        else {
                            $end_time = date_format($end_date, 'Y');
                        }
                    }
                    else {
                        $end_date = date_create();
                        $end_time = $this->translate('Present');
                    }
                    $diff = date_diff($start_date, $end_date);

                ?>

                <div class="experience-time section-subline hidden visible_theme_4 span-background-theme-4">                
                    <span class="start-time"><?php echo $start_time?></span>
                    <span>-</span>
                    <span class="end-time"><?php echo $end_time?></span>
                    <?php $period = $diff->format('%y')*12 + $diff->format('%m') + 1; ?>

                    <?php if ($period > 12) : ?>
                        <?php $years = intval($period / 12);  $months = $period % 12;?>
                        <span class="period">
                            (<?php
                            echo ($years > 0) ? $this->translate(array('%s year','%s years',$years),$years) . ' '  : '';
                            echo ($months > 0) ? $this->translate(array('month_diff','%s months',$months),$months). ' ' : '';
                            ?>)
                        </span>
                    <?php else: ?>
                        <span class="period">(<?php echo $this->translate(array('month_diff','%s months',$period),$period)?>)</span>
                    <?php endif; ?>

                    <?php if ($item->location) : ?>
                        <span class="location"><i class="fa fa-map-marker"></i> <?php echo $item->location?></span>
                    <?php endif;?>
                </div>

                <div>
                    <div class="experience-position section-title inline_theme_4">
                        <?php echo $item->title?>
                    </div>

                    <div class="experience-company section-head-title inline_theme_4">
                    <?php
                    $business = null; 
                    if ($item->business_id) {
                        $business = ($business_enable) ? Engine_Api::_()->getItem('ynbusinesspages_business', $item->business_id) : null;
                    }
                    ?>
                        <span class="company-name"><i class="fa fa-building"></i> <?php echo ($business && !$business->deleted) ? $business : $item->company;?></span>
                        <?php if ($business && !$business->deleted) :?>
                            <span class="company-photo hidden_theme_4 hidden_on_mobile"><?php echo $this->htmlLink($business->gethref(), $this->itemPhoto($business, 'thumb.profile'));?></span>
                        <?php endif;?>
                    </div>
                </div>

                <?php if ($business && !$business->deleted) :?>
                    <div class="company-image hidden visible_theme_4"><?php echo $this->itemPhoto($business, 'thumb.profile');?></div>
                <?php endif;?>
                
                <div class="section-item-calendar">
                    <div>
                        <?php if ($item->start_month) : ?>
                            <span class="month"><?php echo date_format($start_date, 'M');?></span>
                        <?php endif; ?>
                        <span class="year"><?php echo date_format($start_date, 'Y');?></span>
                    </div>

                    <div>
                        <?php if ($item->start_month) : ?>
                            <span class="month"><?php echo date_format($end_date, 'M');?></span>
                        <?php endif; ?>
                        <span class="year"><?php echo date_format($end_date, 'Y');?></span>
                    </div>
                </div>

                <div class="experience-time section-subline hidden_theme_4">                
                    <span class="start-time"><?php echo $start_time?></span>
                    <span>-</span>
                    <span class="end-time"><?php echo $end_time?></span>
                    <?php $period = $diff->format('%y')*12 + $diff->format('%m') + 1;?>

                    <?php if ($period > 12) : ?>
                    <?php $years = intval($period / 12);  $months = $period % 12;?>
                        <span class="period">
                            (<?php
                            echo ($years > 0) ? $this->translate(array('%s year','%s years',$years),$years) . ' '  : '';
                            echo ($months > 0) ? $this->translate(array('month_diff','%s months',$months),$months). ' ' : '';
                            ?>)
                        </span>
                    <?php else: ?>
                        <span class="period">(<?php echo $this->translate(array('month_diff','%s months',$period),$period)?>)</span>
                    <?php endif; ?>

                    <?php if ($item->location) : ?>
                        <span class="location"><i class="fa fa-map-marker"></i> <?php echo $item->location?></span>
                    <?php endif;?>
                </div>

                <div class="experience-location section-subline">                                    
                    <?php $period = $diff->format('%y')*12 + $diff->format('%m') + 1;?>

                    <?php if ($period > 12) : ?>
                    <?php $years = intval($period / 12);  $months = $period % 12;?>
                        <span class="period">
                            (<?php
                            echo ($years > 0) ? $this->translate(array('%s year','%s years',$years),$years) . ' '  : '';
                            echo ($months > 0) ? $this->translate(array('month_diff','%s months',$months),$months). ' ' : '';
                            ?>)
                        </span>
                    <?php else: ?>
                        <span class="period">(<?php echo $this->translate(array('month_diff','%s months',$period),$period)?>)</span>
                    <?php endif; ?>

                    <?php if ($item->location) : ?>
                        <span class="location"><i class="fa fa-map-marker"></i> <?php echo $item->location?></span>
                    <?php endif;?>
                </div>                

                <?php if ($business && !$business->deleted) :?>
                    <div class="company-image hidden view_on_mobile hidden_theme_4"><?php echo $this->itemPhoto($business, 'thumb.profile');?></div>
                <?php endif;?>

            </div>
    
            <?php if ($item->description) : ?>
                <div class="section-description experience-description"><?php echo $item->description?></div>
            <?php endif;?>
    
            <?php $recommendations = Engine_Api::_()->ynresume()->getShowRecommendationsOfOccupation('experience', $item->getIdentity(), $resume->user_id)?>
            <?php if (count($recommendations)) :?>
            <div class="occupation-recommendations">
                <div class="recommendation-label">
                    <a href="javascript:void(0)" class="show-hide-recommendations-btn"><?php echo $this->translate(array('recommendation_count', '%s recommendations', count($recommendations)), count($recommendations))?></a>
                </div>
                <ul class="recomendation-list">
                    <?php foreach ($recommendations as $recommendation) : ?>
                    <li class="recommendation-item">
                        <?php $giver = $recommendation->getGiver();?>
                        <div class="giver-avatar"><?php echo $this->htmlLink($giver->getHref(), $this->itemPhoto($giver, 'thumb.icon'))?></div>
                        <div class="giver-title"><?php echo $this->htmlLink($giver->getHref(), $giver->getTitle())?></div>
                       
                        <div class="giver-headline">
                             <?php if (isset($giver->headline) && !empty($giver->headline)) : ?>
                                <?php if ($giver->title) :?><span><?php echo $giver->title?></span><?php endif; ?>
                                <?php if ($giver->company) :?><span><i class="fa fa-building"></i> <?php echo $giver->company?></span><?php endif; ?>
                            <?php endif;?>
                        </div>
                        
                        <div class="recommendation-content">
                            <?php echo $this->viewMore($recommendation->content, 255, 3*1027);?>
                        </div>
                    </li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <?php endif;?>
            
            <?php $photos = Engine_Api::_()->getItemTable('ynresume_photo')->getPhotosItem($item);?>
            <?php if (count($photos)) :?>
        	<?php $count = 0;?>
            <div class="section-photos">
                <ul class="photo-lists">
                    <?php foreach ($photos as $photo) : ?>
	                <li class="<?php if ($count >= 3) echo 'view-more'?>">
	                    <div class="photo-item">
                            <a href="<?php echo $photo->getPhotoUrl();?>" data-lightbox-gallery="gallery" class="photoSpan" style="background-image: url('<?php echo $photo->getPhotoUrl('thumb.main');?>');"></a>
                            <div class="photo-title"><?php echo $photo->getTitle();?></div>
                        </div>
	                </li>
		            <?php $count++;?>
		            <?php endforeach;?>
                </ul>
                <?php if (count($photos) > 3) : ?>
                <div class="ynresume-photos-showmore">
                    <a href="javascript:void(0)" class="view-more-photos"><i class="fa fa-arrow-down"></i> <?php echo $this->translate('View more')?></a>
                    <a href="javascript:void(0)" class="view-less-photos"><i class="fa fa-arrow-up"></i> <?php echo $this->translate('View less')?></a>
                </div>
            <?php endif; ?>
            </div>
            <?php endif;?>
            <?php if ($manage) : ?>
            <a href="javascript:void(0);" class="edit-section-btn"><i class="fa fa-pencil"></i></a>
            <?php endif; ?>
        </li>
        <?php endforeach;?>    
        </ul>
    </div>
    <?php endif; ?>
    </div>
<?php endif; ?>