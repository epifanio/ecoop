def df2feature(df, lat='LATITUDE',lon='LONGITUDE',prec=5):
    features = []
    try :
        for i, v in enumerate(df): 
            properties = {}
            for j, k in enumerate(df.columns): 
                if df.columns[j] in [lat, lon]:
                    properties[df.columns[j]] = str(df[df.columns[j]][i])[:prec]
                elif df[df.columns[j]][i] > 0:
                    properties[df.columns[j]] = str(df[df.columns[j]][i])[:prec]  #  df[df.columns[j]][i] 
            my_feature = Feature(
                         geometry=Point((df.values[i][4], df.values[i][3])), 
                         properties=properties
                          )
            features.append(my_feature)
        return features
    except:
        print 'done'
    #return features

def addWMS(name, getcapabilities, layername, title):
    wms = """
        var %s = new OpenLayers.Layer.WMS( "%s",
     "%s",
        {layers: '%s',
        transparent: true,
        srs: 'EPSG:4326',
        isBaseLayer: false, 
        visibility: false
        }
 
    );
    map.addLayer(%s);
    %s.setIsBaseLayer(false);
    """ % (name, title, getcapabilities, layername, name, name)
    return wms 


def df2feature(df, lat='LATITUDE',lon='LONGITUDE',prec=5):
    features = []
    try :
        for i, v in enumerate(df): 
            properties = {}
            for j, k in enumerate(df.columns): 
                if df.columns[j] in [lat, lon]:
                    properties[df.columns[j]] = str(df[df.columns[j]][i])[:prec]
                elif df[df.columns[j]][i] > 0:
                    properties[df.columns[j]] = str(df[df.columns[j]][i])[:prec]  #  df[df.columns[j]][i] 
            my_feature = Feature(
                         geometry=Point((df.values[i][4], df.values[i][3])), 
                         properties=properties
                          )
            features.append(my_feature)
    except:
        print 'done'
    return features

def makeSingleStyle(vectorlist):
    fstylish = ''
    for j, k in enumerate(vectorlist):
        stylish = ''
        if vectorlist[j]['type'] == 'point':
            style = '''
            var %s_template = {
                pointRadius: %s,
                strokeColor: "rgb%s",
                strokeOpacity: %s,
                fillColor: "rgb%s",
                fillOpacity: %s
                }
            var %s_style = new OpenLayers.Style(%s_template)
            ''' % (vectorlist[j]['name'], vectorlist[j]['style']['singlestyle']['pointRadius'], vectorlist[j]['style']['singlestyle']['strokeColor'], vectorlist[j]['style']['singlestyle']['strokeOpacity'], vectorlist[j]['style']['singlestyle']['fillColor'], vectorlist[j]['style']['singlestyle']['fillOpacity'], vectorlist[j]['name'], vectorlist[j]['name'])
        fstylish += style
    return fstylish




def makeStyle3(vectorlist):
    
    fstylish = ''
    for j, k in enumerate(vectorlist):
        stylish = ''

        openstyle = '''
        var %s_style = new OpenLayers.Style(
            OpenLayers.Util.applyDefaults({ 
                strokeColor: "${getStrokeColor}",
                strokeOpacity: "${getOpacity}",
                strokeWidth: "${getLineWidth}",
                fillColor: "${getFillColor}",
                fillOpacity: "${getOpacity}"
            }, OpenLayers.Feature.Vector.style["default"]), {
                context: {
                ''' % vectorlist[j]['name']

        OpenOpacity = '''
                    getOpacity: function(feature) {
                    '''
        
        #print vectorlist[j]['style']
        OpacityData = ''
        for i,v in enumerate(vectorlist[j]['style'].keys()):
            if i == 0:
                OpacityData += '''
                        if (feature.attributes.LABEL=="%s"){
                            element=%s;
                        }
                        ''' % (v,vectorlist[j]['style'][v]['Opacity'])
            else:
                OpacityData += '''
                        else if (feature.attributes.LABEL=="%s"){
                            element=%s;
                        }
                        ''' % (v,vectorlist[j]['style'][v]['Opacity'])
        
        CloseOpacity = '''
                        else {
                            element="NULL";
                        }
                        return element;
                    },
                    '''

        OpenStrokeColor = '''
                    getStrokeColor: function(feature) {
                    '''

        StrokeColorData = ''
        for i,v in enumerate(vectorlist[j]['style'].keys()):
            if i == 0:
                StrokeColorData += '''
                        if (feature.attributes.LABEL=="%s"){
                            element="rgb%s";
                        }
                        ''' % (v,vectorlist[j]['style'][v]['StrokeColor'])
            else:
                StrokeColorData += '''
                        else if (feature.attributes.LABEL=="%s"){
                            element="rgb%s";
                        }
                        ''' % (v,vectorlist[j]['style'][v]['StrokeColor'])
        
        CloseStrokeColor = '''
                        else {
                            element="NULL";
                        }
                        return element;
                    },
                    '''

        OpenFillColor = '''
                    getFillColor: function(feature) {
                    '''

        FillColorData = ''
        for i,v in enumerate(vectorlist[j]['style'].keys()):
            if i == 0:
                FillColorData += '''
                        if (feature.attributes.LABEL=="%s"){
                            element="rgb%s";
                        }
                        ''' % (v,vectorlist[j]['style'][v]['FillColor'])
            else:
                FillColorData += '''
                        else if (feature.attributes.LABEL=="%s"){
                            element="rgb%s";
                        }
                        ''' % (v,vectorlist[j]['style'][v]['FillColor'])
        
        CloseFillColor = '''
                        else {
                            element="NULL";
                        }
                        return element;
                    },
                    '''

        OpenLineWidth = '''
                    getLineWidth: function(feature) {
                    '''

        LineWidthData = ''
        for i,v in enumerate(vectorlist[j]['style'].keys()):
            if i == 0:
                LineWidthData += '''
                        if (feature.attributes.LABEL=="%s"){
                            element=%s;
                        }
                        ''' % (v,vectorlist[j]['style'][v]['LineWidth'])
            else:
                LineWidthData += '''
                        else if (feature.attributes.LABEL=="%s"){
                            element=%s;
                        }
                        ''' % (v,vectorlist[j]['style'][v]['LineWidth'])
        
        CloseLineWidth = '''
                        else {
                            element="NULL";
                        }
                        return element;
                    },
                    '''

        CloseStyle = '''
                }
            }
        );'''
        

        stylish += openstyle

        stylish += OpenOpacity
        stylish += OpacityData
        stylish += CloseOpacity

        stylish += OpenStrokeColor
        stylish += StrokeColorData
        stylish += CloseStrokeColor

        stylish += OpenFillColor
        stylish += FillColorData
        stylish += CloseFillColor

        stylish += OpenLineWidth
        stylish += LineWidthData
        stylish += CloseLineWidth

        stylish += CloseStyle
        fstylish += stylish
    return fstylish

def makeQuery3(vectorlist):
    # fields is a list of attributes, 
    # it should be derived directly form an input vector datasource
    # like ogrinfo
    querytemplate = ''
    for i, v in enumerate(vectorlist):
        query = """
        function onPopupClose%s(evt) {
            selectControl.unselect(selectedFeature);
        }
        function onFeatureSelect%s(feature){
            selectedFeature = feature;
        """ %  (vectorlist[i]['name'], vectorlist[i]['name'])
        tablevector = '''tablevector="<html><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><body><table>'''
        for j in vectorlist[i]['fields']:
            tablevector += '''<tr><td><b>%s:</b></td><td><i>"+feature.attributes["%s"]+"</i></td></tr>''' % (j, j)
        tablevector += '''</table></body></html>";'''
        query += tablevector
        query += '''
            popup = new OpenLayers.Popup.FramedCloud("chicken", 
                feature.geometry.getBounds().getCenterLonLat(),
                new OpenLayers.Size(1000,500),
                tablevector,
                null,
                true,
                onPopupClose%s
            ); 
            feature.popup = popup;
            map.addPopup(popup);
        }
        function onFeatureUnselect%s(feature) {
            map.removePopup(feature.popup);
            feature.popup.destroy();
            feature.popup = null;   
        } 
        var %s = new OpenLayers.Layer.Vector("%s", {
        styleMap: %s_style,
        projection: "EPSG:4326",
        strategies: [new OpenLayers.Strategy.Fixed()],
        protocol: new OpenLayers.Protocol.HTTP({
        url: "%s",
        format: new OpenLayers.Format.GeoJSON()
        })
        });
        map.addLayer(%s);
        '''  % (vectorlist[i]['name'], vectorlist[i]['name'], vectorlist[i]['name'], vectorlist[i]['name'], vectorlist[i]['name'], vectorlist[i]['url'], vectorlist[i]['name'])
        querytemplate += query
    return querytemplate
    
    
def control3(vectorlist):
    layerlist = []
    s = ''
    for i , v in enumerate(vectorlist):
        s+=str(vectorlist[i]['name'])+','
    query = """
selectControl = new OpenLayers.Control.SelectFeature(
            [%s ],
            {
                clickout: true, toggle: false, 
                multiple: false, hover: false, 
                toggleKey: "ctrlKey", // ctrl key removes from selection
                multipleKey: "shiftKey" // shift key adds to selection
            }
        );""" % s #vectorlist[i]['name']
    query +="""
        map.addControl(selectControl);
        selectControl.activate();
        """
    for i, v in enumerate(vectorlist):
        query +="""
        %s.events.on({
            "featureselected": function(e) {
                onFeatureSelect%s(e.feature);
            },
            "featureunselected": function(e) {
                onFeatureUnselect%s(e.feature);
            }
        });""" % (vectorlist[i]['name'], vectorlist[i]['name'], vectorlist[i]['name'])
    
    return query