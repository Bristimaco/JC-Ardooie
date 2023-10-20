// TinyMCE Version (5.5.1)
// The controladdin type declares the new add-in.
controladdin TinyMCEEditor
{
    // The Scripts property can reference both external and local scripts.
    Scripts =
'Src/ControlAddins/TinyMCEEditor/script/jquery.min.js',
'Src/ControlAddins/TinyMCEEditor/script/TinyMCEEditor.js',
'Src/ControlAddins/TinyMCEEditor/script/TinyMCEEditorHelper.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/icons/default/icons.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/ar.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/bg_BG.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/bn_BD.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/ca.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/cs.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/cy.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/da.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/de.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/el.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/eo.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/es.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/es_ES.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/es_MX.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/et.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/eu.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/fa.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/fa_IR.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/fi.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/fr_FR.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/gl.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/he_IL.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/hr.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/hu_HU.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/hy.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/id.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/it.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/it_IT.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/ja.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/kab.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/kk.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/ko_KR.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/ku.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/lt.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/nb_NO.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/nl.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/pl.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/pt_BR.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/pt_PT.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/readme.md',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/ro.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/ro_RO.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/ru.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/sk.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/sl.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/sl_SI.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/sv_SE.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/ta.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/ta_IN.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/th_TH.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/tr.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/tr_TR.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/uk.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/vi.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/zh_CN.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/langs/zh_TW.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/advlist/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/anchor/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/autolink/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/autoresize/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/autosave/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/bbcode/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/charmap/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/code/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/codesample/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/colorpicker/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/contextmenu/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/directionality/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/emoticons/js/emojis.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/emoticons/js/emojis.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/emoticons/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/fullpage/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/fullscreen/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/help/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/hr/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/image/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/imagetools/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/importcss/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/insertdatetime/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/legacyoutput/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/link/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/lists/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/media/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/nonbreaking/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/noneditable/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/pagebreak/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/paste/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/preview/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/print/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/quickbars/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/save/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/searchreplace/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/spellchecker/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/tabfocus/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/table/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/template/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/textcolor/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/textpattern/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/toc/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/visualblocks/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/visualchars/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/plugins/wordcount/plugin.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/themes/mobile/theme.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/themes/silver/theme.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/jquery.tinymce.min.js',
'Src/ControlAddins/TinyMCEEditor/tinymce/license.txt',
'Src/ControlAddins/TinyMCEEditor/tinymce/tinymce.d.ts',
'Src/ControlAddins/TinyMCEEditor/tinymce/tinymce.min.js';

    // The StartupScript is a special script that the web client calls once the page is loaded.
    StartupScript =
'Src/ControlAddins/TinyMCEEditor/script/TinyMCEEditorStartUp.js';

    // Specifies the StyleSheets that are included in the control add-in.
    StyleSheets =
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/dark/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/default/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/document/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/tinymceeditor-black/content.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/tinymceeditor-black/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/tinymceeditor-blue/content.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/tinymceeditor-blue/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/tinymceeditor-dark/content.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/tinymceeditor-dark/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/tinymceeditor-dark-gray/content.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/tinymceeditor-dark-gray/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/tinymceeditor-dark-green/content.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/tinymceeditor-dark-green/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/tinymceeditor-gray/content.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/tinymceeditor-gray/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/content/writer/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/oxide/fonts/tinymce-mobile.woff',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/oxide/content.inline.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/oxide/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/oxide/content.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/oxide/skin.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/oxide/skin.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/oxide-dark/fonts/tinymce-mobile.woff',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/oxide-dark/content.inline.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/oxide-dark/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/oxide-dark/content.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/oxide-dark/skin.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/oxide-dark/skin.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-black/fonts/tinymce-mobile.woff',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-black/content.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-black/content.inline.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-black/content.inline.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-black/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-black/content.mobile.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-black/content.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-black/skin.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-black/skin.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-black/skin.mobile.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-black/skin.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-blue/fonts/tinymce-mobile.woff',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-blue/content.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-blue/content.inline.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-blue/content.inline.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-blue/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-blue/content.mobile.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-blue/content.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-blue/skin.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-blue/skin.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-blue/skin.mobile.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-blue/skin.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark/fonts/tinymce-mobile.woff',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark/content.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark/content.inline.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark/content.inline.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark/content.mobile.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark/content.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark/skin.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark/skin.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark/skin.mobile.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark/skin.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-gray/fonts/tinymce-mobile.woff',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-gray/content.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-gray/content.inline.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-gray/content.inline.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-gray/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-gray/content.mobile.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-gray/content.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-gray/skin.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-gray/skin.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-gray/skin.mobile.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-gray/skin.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-green/fonts/tinymce-mobile.woff',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-green/content.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-green/content.inline.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-green/content.inline.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-green/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-green/content.mobile.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-green/content.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-green/skin.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-green/skin.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-green/skin.mobile.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-dark-green/skin.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-gray/fonts/tinymce-mobile.woff',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-gray/content.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-gray/content.inline.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-gray/content.inline.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-gray/content.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-gray/content.mobile.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-gray/content.mobile.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-gray/skin.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-gray/skin.min.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-gray/skin.mobile.css',
'Src/ControlAddins/TinyMCEEditor/tinymce/skins/ui/tinymceeditor-gray/skin.mobile.min.css';

    // Specifies the Images that are included in the control add-in.
    Images =
'Src/ControlAddins/TinyMCEEditor/image/Loader.gif';

    // Sizing of the control add-in.
    RequestedHeight = 500;
    RequestedWidth = 320;
    MinimumHeight = 180;
    MinimumWidth = 200;
    //MaximumHeight = ???;
    //MaximumWidth = ???;
    VerticalStretch = true;
    HorizontalStretch = true;
    VerticalShrink = true;
    HorizontalShrink = true;

    // The procedure declarations specify what JavaScript methods could be called from AL.
    procedure SetSkinIconAndCss(pSkinName: Text; pIconSize: Text; pCssName: Text; pCssCores: Boolean);
    procedure SetFonts(pFonts: Text);
    procedure SetFontSize(pFontSize: Text);
    procedure SetLanguage(pLanguage: Text; pDirectionality: Text);
    procedure SetTokenProvider(pTokenProvider: Text);
    procedure SetDropboxAppKey(pDropboxAppKey: Text);
    procedure SetGoogleDriveKey(pGoogleDriveKey: Text);
    procedure SetGoogleDriveClientId(pGoogleDriveClientid: Text);
    procedure SetOnlineScriptUrl(pUrl: Text; pFreeLicense: Boolean);
    procedure SetEditable(pEditable: Boolean);
    procedure SetHtmlSchema(pSchema: Text);
    procedure SetAutoSave(pSecond: Integer; pConfirm: Boolean);
    procedure InitContent(pIsText: Boolean; pIsFixContentType: Boolean);
    procedure SetContent(pContent: Text);
    procedure SetContentBlock(pBlock: Text);
    procedure GetContentAs(pIsText: Boolean);
    procedure SetEnableContentEventOn(pInput: Boolean; pKeyup: Boolean; pChange: Boolean; pNodeChange: Boolean);
    procedure SetContentType(pIsText: Boolean; pIsFixContentType: Boolean);
    procedure SetContentStyle(pStyle: Text);
    procedure SetEnablePremiumPlugin();
    procedure GetDefaultFonts();
    procedure GetDefaultFontSize();
    procedure SetDispose();
    procedure SetViewMode();
    procedure SetShowMenu();
    procedure GetVersion();
    procedure GetAvaiableSkin();
    procedure SetHideBrand();
    procedure SetHideToolbar();
    procedure SetContentOnly();
    procedure GetContent();

    // The event declarations specify what callbacks could be raised from JavaScript by using the webclient API:
    event ContentHasSaved();
    event ContentTypeHasChanged();
    event ContentHasChanged(EventName: Text);
    event ContentText(Contents: Text; IsText: Boolean);
    event ControlAddInReady(IsReady: Boolean);
    event DocumentReady(IsReady: Boolean);
}
