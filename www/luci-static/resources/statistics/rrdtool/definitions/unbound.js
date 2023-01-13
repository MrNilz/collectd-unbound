'use strict';
'require baseclass';
return baseclass.extend({

	title: _('Unbound'),

	rrdargs: function(graph, host, plugin, plugin_instance, dtype) {

		/* Recursion Time graph */
		var time = {
			title: "Recursion Time",
			vlabel: "secounds",
            y_min:"0",
            units_exponent:"0",
            number_format:"%5.2lf",
			data: {
				instances: {
					"gauge": ["total.recursion.time.avg", "total.recursion.time.median"]
				},
				options: {
					"gauge_total.recursion.time.avg": {
                        title:"Average Recursion Time",
                        color:"0000ff", 
                        noarea:true,
                        weight:1
                    },
					"gauge_total.recursion.time.median": {
                        title:"Median of Recursion Time",
                        color:"ff00ff",
                        noarea:true,
                        weight:2
                    }
				}
			}
		};
        
		/* Requestlist graph */
		var requestlist = {
			title: "Requestlist",
			vlabel: "count",
            y_min:"0",
            number_format:"%5.2lf",
			data: {
				instances: {
					"derive": ["total.requestlist.max", "total.requestlist.exceeded" ],
					"gauge": ["total.requestlist.current.all", "total.requestlist.avg"]
				},
				options: {
					"gauge_total.requestlist.current.all": {
						title:"Current Length",
                        overlay:true,
                        weight:1
					},
					"gauge_total.requestlist.avg": {
						title:"Average Length",
                        color:"000000", 
                        overlay:true,
                        noarea:true,
                        weight:2
					},
					"derive_total.requestlist.exceeded": {
						title:"Queries Dropped",
                        color:"ff8c00", 
                        overlay:true,
                        weight:3
					},
					"derive_total.requestlist.max": {
						title:"Max Length Reached",
                        color:"ff0000",
                        overlay:true,
                        weight:4
					},
				}
			}
		};
        
        /* Queries graph */
		var queries = {
			title: "Queries",
			vlabel: "count",
            y_min:"0",
            units_exponent:"0",
            number_format:"%5.2lf",
			data: {
				instances: {
					"derive": ["total.num.prefetch", "total.num.cachehits", "total.num.cachemiss", "total.num.recursivereplies", "total.requestlist.exceeded" ]
				},
				options: {
					"derive_total.num.cachehits": {
						title:"Cachehits",
                        color:"1e90ff", 
                        noarea:true,
                        overlay:true,
                        weight:4
					},
					"derive_total.num.cachemiss": {
						title:"Cachemiss",
                        color:"ff8c00", 
                        noarea:true,
                        overlay:true,
                        weight:3
					},
					"derive_total.num.prefetch": {
						title:"Prefetches",
                        color:"1B8E2D", 
                        overlay:true,
                        weight:2
					},
					"derive_total.num.recursivereplies": {
						title:"Recursivereplies",
                        color:"ffa500", 
                        overlay:true,
                        weight:1
					},
					"derive_total.requestlist.exceeded": {
						title:"Queries Dropped",
                        color:"ff0000",
                        overlay:true,
                        weight:5
					},
				}
			}
		};
        

        return [time, requestlist, queries];
	}

});