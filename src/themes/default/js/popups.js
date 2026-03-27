(function(){
  if (window.__nvPopupsInit) return;
  window.__nvPopupsInit = true;
  window.__nvPopupsLoaded = true;
  var previewId = 0;
  var previewOnly = 0;
  var previewActive = false;
  try{
    if (window.location && window.location.search) {
      if (typeof URLSearchParams === 'function') {
        var usp = new URLSearchParams(window.location.search);
        previewId = parseInt(usp.get('popup_preview_id') || usp.get('preview_id') || usp.get('popup_id') || '0', 10) || 0;
        previewOnly = parseInt(usp.get('popup_preview_only') || usp.get('preview_only') || usp.get('isonly') || '0', 10) || 0;
      } else {
        var m = window.location.search.match(/[?&](?:popup_preview_id|preview_id|popup_id)=([0-9]+)/);
        if (m) previewId = parseInt(m[1] || '0', 10) || 0;
        var m2 = window.location.search.match(/[?&](?:popup_preview_only|preview_only|isonly)=([0-9]+)/);
        if (m2) previewOnly = parseInt(m2[1] || '0', 10) || 0;
      }
    }
  }catch(e){ previewId = 0; }
  if (typeof nv_area_admin !== 'undefined' && parseInt(nv_area_admin, 10) === 1 && previewId <= 0) return;
  function daysSince(ts){
    if(!ts) return Infinity;
    var diff = Date.now() - parseInt(ts,10);
    return diff / 86400000;
  }
  function getCookie(name){
    try{
      var parts = (document.cookie || '').split(';');
      for (var i = 0; i < parts.length; i++) {
        var p = parts[i].trim();
        if (!p) continue;
        if (p.indexOf(name + '=') === 0) {
          return decodeURIComponent(p.substring(name.length + 1));
        }
      }
    }catch(e){}
    return '';
  }
  function getPageScope(){
    try{
      var mEl = document.querySelector('meta[name="nv-popups-module"]');
      var mod = mEl ? (mEl.getAttribute('content') || '') : '';
      if (!mod) return 'site';
      return String(mod);
    }catch(e){ return 'site'; }
  }
  function setCookie(name, value, maxAgeSeconds){
    try{
      var cookie = name + '=' + encodeURIComponent(String(value)) + '; Max-Age=' + parseInt(maxAgeSeconds, 10) + '; Path=/; SameSite=Lax';
      if (window.location && window.location.protocol === 'https:') {
        cookie += '; Secure';
      }
      document.cookie = cookie;
    }catch(e){}
  }
  function setSessionCookie(name, value){
    try{
      var cookie = name + '=' + encodeURIComponent(String(value)) + '; Path=/; SameSite=Lax';
      if (window.location && window.location.protocol === 'https:') {
        cookie += '; Secure';
      }
      document.cookie = cookie;
    }catch(e){}
  }
  function getShowCount(id){
    return parseInt(getCookie('nv_popups_cnt_' + id) || '0', 10) || 0;
  }
  function setShowCount(id, value){
    setCookie('nv_popups_cnt_' + id, parseInt(value, 10) || 0, 315360000);
  }
  function getShowKey(data){
    var id = parseInt(data && data.id || 0, 10) || 0;
    var scope = getPageScope();
    var t = parseInt(data && data.display_type || 0, 10) || 0;
    if (t === 1) return 'nv_popups_sh_s_' + id + '_' + scope;
    if (t === 2) return 'nv_popups_sh_d_' + id + '_' + scope;
    if (t === 3) return 'nv_popups_sh_m_' + id + '_' + scope;
    return '';
  }
  function shouldTrack(id, act){
    var ttl = 600;
    if (act === 'click') ttl = 2;
    if (act === 'close') ttl = 600;
    var key = 'nv_popups_trk_' + act + '_' + id;
    var now = Math.floor(Date.now() / 1000);
    var last = parseInt(getCookie(key) || '0', 10) || 0;
    if (last > 0 && (now - last) < ttl) return false;
    setCookie(key, now, ttl);
    return true;
  }
  function shouldShow(data){
    if(previewActive) return true;
    var id = parseInt(data && data.id || 0, 10) || 0;
    var maxShow = parseInt(data && data.max_show || 0, 10) || 0;
    if (id > 0 && maxShow > 0 && getShowCount(id) >= maxShow) return false;
    var t = parseInt(data && data.display_type || 0, 10) || 0;
    if (t === 4) return true;
    if (t === 1 || t === 2 || t === 3) {
      var k = getShowKey(data);
      return !getCookie(k);
    }
    try{
      var freq = parseInt(data && data.freq || 0, 10) || 0;
      if(freq <= 0) return true;
      return !getCookie('nv_popups_sh_f_' + id);
    }catch(e){ return true; }
  }
  function setShown(data){
    if(previewActive) return;
    var id = parseInt(data && data.id || 0, 10) || 0;
    if (id <= 0) return;
    var maxShow = parseInt(data && data.max_show || 0, 10) || 0;
    if (maxShow > 0) {
      setShowCount(id, getShowCount(id) + 1);
    }
    var t = parseInt(data && data.display_type || 0, 10) || 0;
    if (t === 1) {
      setSessionCookie(getShowKey(data), String(Math.floor(Date.now() / 1000)));
      return;
    }
    if (t === 2) {
      setCookie(getShowKey(data), String(Math.floor(Date.now() / 1000)), 86400);
      return;
    }
    if (t === 3) {
      var mins = parseInt(data && data.display_interval || 0, 10) || 0;
      if (mins < 1) mins = 30;
      setCookie(getShowKey(data), String(Math.floor(Date.now() / 1000)), mins * 60);
      return;
    }
    try{
      var freq = parseInt(data && data.freq || 0, 10) || 0;
      if (freq > 0) {
        setCookie('nv_popups_sh_f_' + id, String(Math.floor(Date.now() / 1000)), freq * 86400);
      }
    }catch(e){}
  }
  function track(url, id, act){
    if(previewActive) return;
    if(!shouldTrack(id, act)) return;
    try{
      var fd = new FormData();
      fd.append("id", id);
      fd.append("act", act);
      if (typeof fetch === 'function') {
        fetch(url, {method:"POST", body: fd});
        return;
      }
      var xhr = new XMLHttpRequest();
      xhr.open('POST', url, true);
      xhr.send(fd);
    }catch(e){}
  }
  function hasBootstrapModal(){
    return !!(window.bootstrap && bootstrap.Modal && typeof bootstrap.Modal.getOrCreateInstance === 'function');
  }
  function escapeHtml(str){
    return (str == null ? '' : String(str))
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#039;');
  }
  function buildModal(data){
    var isBs = hasBootstrapModal();
    var backdrop = '';
    var size = '';
    var viewMoreText = data.view_more_text || '';
    var closeText = data.close_text || (typeof nv_close !== 'undefined' ? nv_close : (window.nukeviet && nukeviet.i18n && nukeviet.i18n.close ? nukeviet.i18n.close : ''));
    var urlBtn = data.url ? '<div class="nv-popups-actions mt-2"><a href="'+escapeHtml(data.url)+'" target="'+escapeHtml(data.target || '_self')+'" class="nv-popups-link btn btn-primary btn-sm">'+escapeHtml(viewMoreText)+'</a></div>' : '';
    var desc = data.description ? '<p class="nv-popups-desc">'+escapeHtml(data.description)+'</p>' : '';
    var content = data.content ? '<div class="nv-popups-info">'+data.content+'</div>' : '';
    var header = '';
    var footerBtn = '';
    if (isBs) {
      if (data.close_outside === 0) {
        backdrop = ' data-bs-backdrop="static" data-bs-keyboard="false"';
      }
      if (data.layout === 2) {
        size = ' modal-lg';
      } else {
        size = ' modal-sm';
      }
      header = '<div class="modal-header bg-primary text-white"><div class="modal-title">'+escapeHtml(data.title || '')+'</div><button type="button" class="nv-popups-x text-white" data-bs-dismiss="modal" aria-label="'+escapeHtml(closeText)+'">×</button></div>';
      footerBtn = '<div class="modal-footer"><button type="button" class="btn btn-primary" data-bs-dismiss="modal">'+escapeHtml(closeText)+'</button></div>';
    } else {
      header = '<div class="nv-popups-header bg-primary text-white"><div class="nv-popups-header-title">'+escapeHtml(data.title || '')+'</div><button type="button" class="nv-popups-x text-white" aria-label="'+escapeHtml(closeText)+'" data-nv-popups-close="1">×</button></div>';
      if (!data.title) {
        header = '<div class="nv-popups-header bg-primary text-white"><div class="nv-popups-header-title"></div><button type="button" class="nv-popups-x text-white" aria-label="'+escapeHtml(closeText)+'" data-nv-popups-close="1">×</button></div>';
      }
      footerBtn = '<div class="nv-popups-footer"><button type="button" class="nv-popups-close btn btn-primary">'+escapeHtml(closeText)+'</button></div>';
    }

    var layoutClass = (data.layout === 2 ? 'nv-popups-layout-2' : 'nv-popups-layout-1');
    var wrapperClass = isBs ? 'modal fade nv-popups-modal ' + layoutClass + ' ' : 'nv-popups-overlay nv-popups-modal ' + layoutClass + ' ';
    var wrapperId = 'nv-popups-modal-' + data.id;
    var wrapperAttrs = ' id="'+wrapperId+'" tabindex="-1" role="dialog" data-id="'+data.id+'" data-delay="'+data.delay+'" data-freq="'+data.freq+'" data-track-url="'+escapeHtml(data.track_url||'')+'"';
    if (isBs) wrapperAttrs += backdrop;
    if (data.close_outside === 0) wrapperAttrs += ' data-close-outside="0"';
    var dialogOpen = isBs ? '<div class="modal-dialog modal-dialog-centered'+size+'" role="document">' : '<div class="nv-popups-dialog'+(data.layout === 2 ? ' nv-popups-lg' : '')+'" role="document">';
    var dialogContentClass = isBs ? 'modal-content' : 'nv-popups-contentbox';
    var bodyClass = isBs ? 'modal-body nv-popups-content' : 'nv-popups-body nv-popups-content';

    var html = '<div class="'+wrapperClass+(data.css_class||'')+'"'+wrapperAttrs+'>'+
      dialogOpen+
      '<div class="'+dialogContentClass+'">'+
      header+
      '<div class="'+bodyClass+'">'+desc+content+urlBtn+'</div>'+
      footerBtn+
      '</div></div></div>';
    var wrapper = document.createElement('div');
    wrapper.innerHTML = html;
    document.body.appendChild(wrapper.firstChild);
    return document.getElementById(wrapperId);
  }
  function showSequential(list){
    var idx = 0;
    function next(){
      if(idx >= list.length) return;
      var data = list[idx++];
      if(!shouldShow(data)) { next(); return; }
      var el = buildModal(data);
      var trackUrl = data.track_url || '';
      setTimeout(function(){
        var useBs = hasBootstrapModal();
        var escHandler = null;
        var close = function(){
          if(trackUrl){ track(trackUrl, data.id, 'close'); }
          if (!useBs) {
            if (escHandler) document.removeEventListener('keydown', escHandler);
            if (el && el.parentNode) el.parentNode.removeChild(el);
            document.body.classList.remove('nv-popups-lock');
          }
          next();
        };
        if (useBs) {
          try{
            var modal = bootstrap.Modal.getOrCreateInstance(el);
            modal.show();
          }catch(e){
            useBs = false;
          }
        }
        if (!useBs) {
          try{
            el.classList.add('nv-popups-open');
            document.body.classList.add('nv-popups-lock');
            el.style.display = 'flex';
            el.style.position = 'fixed';
            el.style.left = '0';
            el.style.top = '0';
            el.style.right = '0';
            el.style.bottom = '0';
            el.style.alignItems = 'center';
            el.style.justifyContent = 'center';
            el.style.background = 'rgba(0,0,0,.55)';
            el.style.zIndex = '2147483647';
          }catch(e){
            useBs = false;
          }
        }

        setShown(data);
        if(trackUrl){ track(trackUrl, data.id, 'view'); }

        if (useBs) {
          el.addEventListener('hidden.bs.modal', function(){
            try{ el.remove(); }catch(e){ if (el && el.parentNode) el.parentNode.removeChild(el); }
            close();
          }, {once:true});
        } else {
          var closeOutside = el.getAttribute('data-close-outside') !== '0';
          el.addEventListener('click', function(e){
            if (e.target === el && closeOutside) close();
          });
          el.querySelectorAll('[data-nv-popups-close="1"], .nv-popups-close').forEach(function(btn){
            btn.addEventListener('click', function(){ close(); });
          });
          escHandler = function(e){
            if (e.key === 'Escape') close();
          };
          document.addEventListener('keydown', escHandler);
        }
        el.querySelectorAll('a').forEach(function(a){
          a.addEventListener('click', function(){ if(trackUrl){ track(trackUrl, data.id, 'click'); } });
        });
      }, Math.max(0, (data.delay||0) * 1000));
    }
    next();
  }
  function getListUrl(){
    var base = (typeof nv_base_siteurl !== 'undefined' ? nv_base_siteurl : '/');
    var langVar = (typeof nv_lang_variable !== 'undefined' ? nv_lang_variable : 'language');
    var langData = (typeof nv_lang_data !== 'undefined' ? nv_lang_data : 'vi');
    var nameVar = (typeof nv_name_variable !== 'undefined' ? nv_name_variable : 'nv');
    var opVar = (typeof nv_fc_variable !== 'undefined' ? nv_fc_variable : 'op');
    var pid = 0;
    try{
      var m = document.querySelector('meta[name="nv-popups-pageid"]');
      if(m){
        pid = parseInt(m.getAttribute('content') || '0', 10) || 0;
      }
    }catch(e){ pid = 0; }
    var url = base + 'index.php?' + encodeURIComponent(langVar) + '=' + encodeURIComponent(langData) + '&' + encodeURIComponent(nameVar) + '=popups&' + encodeURIComponent(opVar) + '=main&list=1';
    if (pid > 0) {
      url += '&pid=' + encodeURIComponent(pid);
    }
    try{
      var mEl = document.querySelector('meta[name="nv-popups-module"]');
      var fEl = document.querySelector('meta[name="nv-popups-op"]');
      var iidEl = document.querySelector('meta[name="nv-popups-itemid"]');
      var mod = mEl ? (mEl.getAttribute('content') || '') : '';
      var fun = fEl ? (fEl.getAttribute('content') || '') : '';
      var iid = iidEl ? (parseInt(iidEl.getAttribute('content') || '0', 10) || 0) : 0;
      if (mod === 'news' && iid > 0) {
        fun = 'detail';
      }
      if (mod) url += '&m=' + encodeURIComponent(mod);
      if (fun) url += '&f=' + encodeURIComponent(fun);
      if (iid > 0) url += '&iid=' + encodeURIComponent(iid);
    }catch(e){}
    if (previewId > 0) {
      url += '&preview_id=' + encodeURIComponent(previewId);
      if (previewOnly > 0) {
        url += '&preview_only=1';
      }
    }
    return url;
  }
  function loadAndShow(){
    try{
      var url = getListUrl();
      if (typeof fetch === 'function') {
        fetch(url).then(function(r){return r.json();}).then(function(data){
          var hasPopups = !!(data && Array.isArray(data.popups) && data.popups.length);
          if (previewId > 0) {
            previewActive = (parseInt(data && data.preview_mode || 0, 10) === 1);
            if (!previewActive) {
              try{ if (data && data.preview_error) alert(String(data.preview_error)); }catch(e){}
              return;
            }
          }
          if(hasPopups){
            if (previewActive && previewOnly > 0) {
              data.popups = data.popups.filter(function(p){ return parseInt(p && p.id || 0, 10) === previewId; });
              data.popups.forEach(function(p){
                try{
                  p.delay = 0;
                  p.freq = 0;
                }catch(e){}
              });
            }
            if (previewActive && previewOnly > 0 && !data.popups.length) {
              try{ if (data && data.preview_error) alert(String(data.preview_error)); }catch(e){}
              return;
            }
            data.popups.sort(function(a, b){
              var ap = parseInt(a.priority || 0, 10);
              var bp = parseInt(b.priority || 0, 10);
              if (bp !== ap) return bp - ap;
              var at = parseInt(a.updated_time || 0, 10);
              var bt = parseInt(b.updated_time || 0, 10);
              return bt - at;
            });
            showSequential(data.popups);
          } else if (previewId > 0) {
            try{ if (data && data.preview_error) alert(String(data.preview_error)); }catch(e){}
          }
        }).catch(function(){});
        return;
      }
      var xhr = new XMLHttpRequest();
      xhr.open('GET', url, true);
      xhr.onreadystatechange = function(){
        if (xhr.readyState !== 4) return;
        if (xhr.status >= 200 && xhr.status < 300) {
          try{
            var data = JSON.parse(xhr.responseText);
            var hasPopups = !!(data && Array.isArray(data.popups) && data.popups.length);
            if (previewId > 0) {
              previewActive = (parseInt(data && data.preview_mode || 0, 10) === 1);
              if (!previewActive) {
                try{ if (data && data.preview_error) alert(String(data.preview_error)); }catch(e){}
                return;
              }
            }
            if(hasPopups){
              if (previewActive && previewOnly > 0) {
                data.popups = data.popups.filter(function(p){ return parseInt(p && p.id || 0, 10) === previewId; });
                data.popups.forEach(function(p){
                  try{
                    p.delay = 0;
                    p.freq = 0;
                  }catch(e){}
                });
              }
              if (previewActive && previewOnly > 0 && !data.popups.length) {
                try{ if (data && data.preview_error) alert(String(data.preview_error)); }catch(e){}
                return;
              }
              data.popups.sort(function(a, b){
                var ap = parseInt(a.priority || 0, 10);
                var bp = parseInt(b.priority || 0, 10);
                if (bp !== ap) return bp - ap;
                var at = parseInt(a.updated_time || 0, 10);
                var bt = parseInt(b.updated_time || 0, 10);
                return bt - at;
              });
              showSequential(data.popups);
            } else if (previewId > 0) {
              try{ if (data && data.preview_error) alert(String(data.preview_error)); }catch(e){}
            }
          }catch(e){}
        }
      };
      xhr.send(null);
    }catch(e){}
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', loadAndShow);
  } else {
    loadAndShow();
  }
})();
