// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'Wonderous';

  @override
  String get localeSwapButton => 'English';

  @override
  String animatedArrowSemanticSwipe(Object title) {
    return '查看关于$title的详细信息。';
  }

  @override
  String get appBarTitleFactsHistory => '历史与细节';

  @override
  String get appBarTitleConstruction => '建造';

  @override
  String get appBarTitleLocation => '地理位置';

  @override
  String get bottomScrubberSemanticScrubber => 'scrubber';

  @override
  String get bottomScrubberSemanticTimeline =>
      'Timeline Scrubber，水平拖动可在历史年表中导航。';

  @override
  String collectionLabelDiscovered(Object percentage) {
    return '已发现 $percentage% ';
  }

  @override
  String collectionLabelCount(Object count, Object total) {
    return '$count/$total';
  }

  @override
  String get collectionButtonReset => '重置收藏夹';

  @override
  String get eventsListButtonOpenGlobal => '打开世界历史年表';

  @override
  String newlyDiscoveredSemanticNew(Object count, Object suffix) {
    return '$count要探索的新项目。滚动到新项目';
  }

  @override
  String newlyDiscoveredLabelNew(Object count, Object suffix) {
    return '$count要探索的新项目';
  }

  @override
  String get resultsPopupEnglishContent => '本内容由大都会艺术博物馆收藏API提供，仅提供英文版本。';

  @override
  String get resultsSemanticDismiss => '解除信息';

  @override
  String get scrollingContentSemanticYoutube => 'Youtube 视频缩略图';

  @override
  String get scrollingContentSemanticOpen => '打开全屏地图';

  @override
  String get searchInputTitleSuggestions => '建议';

  @override
  String get searchInputHintSearch => '搜索';

  @override
  String get searchInputSemanticClear => '删除搜索';

  @override
  String timelineSemanticDate(Object fromDate, Object endDate) {
    return '$fromDate 至 $endDate';
  }

  @override
  String titleLabelDate(Object fromDate, Object endDate) {
    return '$fromDate ~ $endDate';
  }

  @override
  String get appModalsButtonOk => '确定';

  @override
  String get appModalsButtonCancel => '取消';

  @override
  String get appPageDefaultTitlePage => '页';

  @override
  String appPageSemanticSwipe(Object pageTitle, Object current, Object total) {
    return '$pageTitle $total 之 $current.';
  }

  @override
  String get artifactsTitleArtifacts => '文物';

  @override
  String semanticsPrevious(Object title) {
    return '之前的文物$title';
  }

  @override
  String semanticsNext(Object title) {
    return '下一个文物$title';
  }

  @override
  String get artifactsSemanticsPrevious => '之前的文物';

  @override
  String get artifactsSemanticsNext => '下一个文物';

  @override
  String get artifactsSemanticArtifact => '文物';

  @override
  String get artifactsButtonBrowse => '游览所有文物';

  @override
  String get artifactDetailsLabelDate => '日期';

  @override
  String get artifactDetailsLabelPeriod => '年代';

  @override
  String get artifactDetailsLabelGeography => '地理位置';

  @override
  String get artifactDetailsLabelMedium => '类型';

  @override
  String get artifactDetailsLabelDimension => '尺寸';

  @override
  String get artifactDetailsLabelClassification => '级别';

  @override
  String get artifactDetailsSemanticThumbnail => '缩略图';

  @override
  String artifactDetailsErrorNotFound(Object artifactId) {
    return '无法搜到工件 $artifactId 的信息';
  }

  @override
  String get artifactsSearchTitleBrowse => '游览文物';

  @override
  String get artifactsSearchLabelNotFound => '未能搜到文物';

  @override
  String get artifactsSearchButtonToggle => '切换日期范围';

  @override
  String get artifactsSearchSemanticTimeframe => '日期范围';

  @override
  String artifactsSearchLabelFound(Object numFound, Object numResults) {
    return '$numFound文物搜到，$numResults在';
  }

  @override
  String get artifactsSearchLabelAdjust => '调整您的';

  @override
  String get artifactsSearchLabelSearch => '搜索词';

  @override
  String get artifactsSearchLabelTimeframe => '日期范围';

  @override
  String get circleButtonsSemanticClose => '关闭';

  @override
  String get circleButtonsSemanticBack => '返回';

  @override
  String get collectibleFoundTitleArtifactDiscovered => '已发现的文物';

  @override
  String get collectibleFoundButtonViewCollection => '在收藏里观看文物';

  @override
  String get collectibleItemSemanticCollectible => '收藏物品';

  @override
  String get collectionTitleCollection => '收藏';

  @override
  String get collectionPopupResetConfirm => '您确定要重置您的收藏吗?';

  @override
  String get eightWaySemanticSwipeDetector => '八方滑动识别器';

  @override
  String get expandingTimeSelectorSemanticSelector => '日期范围选择器';

  @override
  String get fullscreenImageViewerSemanticFull => '全屏图像，没有描述信息';

  @override
  String get homeMenuButtonExplore => '探索历史年表';

  @override
  String get homeMenuButtonView => '观看您的收藏';

  @override
  String get homeMenuButtonAbout => '关于这个应用程序';

  @override
  String get homeMenuAboutWonderous => 'Wonderous是世界八大奇迹的视觉展示。';

  @override
  String homeMenuAboutBuilt(Object flutterUrl, Object gskinnerUrl) {
    return '由 $gskinnerUrl 团队使用 $flutterUrl 构建。';
  }

  @override
  String homeMenuAboutLearn(Object wonderousUrl) {
    return '在 $wonderousUrl 上了解更多信息。';
  }

  @override
  String homeMenuAboutSource(Object githubUrl) {
    return '要查看这个应用程序的源代码，请访问 $githubUrl。';
  }

  @override
  String get homeMenuAboutRepo => 'Wonderous github 储存库';

  @override
  String get homeMenuAboutFlutter => 'Flutter';

  @override
  String get homeMenuAboutGskinner => 'gskinner';

  @override
  String get homeMenuAboutApp => 'wonderous.app';

  @override
  String homeMenuAboutPublic(Object metUrl) {
    return '来自$metUrl的公共领域艺术品。';
  }

  @override
  String get homeMenuAboutMet => '纽约大都会艺术博物馆';

  @override
  String homeMenuAboutPhotography(Object unsplashUrl) {
    return '来自$unsplashUrl的照片。';
  }

  @override
  String get homeMenuAboutUnsplash => 'Unsplash';

  @override
  String get introTitleJourney => '穿越过去之旅';

  @override
  String get introDescriptionNavigate => '浏览时光、艺术和文化的交汇处。';

  @override
  String get introTitleExplore => '探索名胜古迹';

  @override
  String get introDescriptionUncover => '发掘世界各地非凡的人造建筑。';

  @override
  String get introTitleDiscover => '发现文物';

  @override
  String get introDescriptionLearn => '研究历史文物，了解历史文化';

  @override
  String get introSemanticNavigate => '浏览';

  @override
  String get introSemanticSwipeLeft => '向左滑动以继续浏览';

  @override
  String get introSemanticEnterApp => '进入应用程序';

  @override
  String get introSemanticWonderous => 'Wonderous';

  @override
  String get labelledToggleSemanticToggle => '切换';

  @override
  String get photoGallerySemanticCollectible => '收藏品!';

  @override
  String photoGallerySemanticFocus(Object photoIndex, Object photoTotal) {
    return '$photoTotal 张照片中的第 $photoIndex 张。点击聚焦。';
  }

  @override
  String photoGallerySemanticFullscreen(Object photoIndex, Object photoTotal) {
    return '$photoTotal 张照片中的第 $photoIndex 张。点击以打开全屏视图。';
  }

  @override
  String get eraPrehistory => '史前时代';

  @override
  String get eraClassical => '古典时代';

  @override
  String get eraEarlyModern => '早期现代';

  @override
  String get eraModern => '现代';

  @override
  String get yearBCE => '公元前';

  @override
  String get yearCE => '公元后';

  @override
  String yearFormat(Object date, Object era) {
    return '$era$date年';
  }

  @override
  String get year => '年';

  @override
  String timelineLabelConstruction(Object title) {
    return '$title的建造开始。';
  }

  @override
  String get timelineTitleGlobalTimeline => '世界历史年表';

  @override
  String get wallpaperModalSave => '将此海报保存到您的照片库？';

  @override
  String get wallpaperModalSaving => '请稍等, 保存图像中...';

  @override
  String get wallpaperModalSaveComplete => '保存完成!';

  @override
  String get wallpaperSemanticSharePhoto => '分享照片';

  @override
  String get wallpaperSemanticTakePhoto => '拍照';

  @override
  String get wallpaperCheckboxShowTitle => '显示标题';

  @override
  String get wonderDetailsTabLabelInformation => '信息和历史';

  @override
  String get wonderDetailsTabLabelImages => '照片库';

  @override
  String get wonderDetailsTabLabelArtifacts => '文物';

  @override
  String get wonderDetailsTabLabelEvents => '事件';

  @override
  String get wonderDetailsTabSemanticBack => '回到 Wonder 选择';

  @override
  String get homeSemanticOpenMain => '打开主菜单';

  @override
  String get homeSemanticWonder => 'Wonder';

  @override
  String get chichenItzaTitle => '奇琴伊察';

  @override
  String get chichenItzaSubTitle => '伟大的玛雅城市';

  @override
  String get chichenItzaRegionTitle => '墨西哥尤卡坦半岛';

  @override
  String get chichenItzaArtifactCulture => '玛雅';

  @override
  String get chichenItzaArtifactGeolocation => '北美洲、中美洲';

  @override
  String get chichenItzaPullQuote1Top => '天堂和地狱';

  @override
  String get chichenItzaPullQuote1Bottom => '之间的美观';

  @override
  String get chichenItzaPullQuote2 => '从当地的石制遗迹和艺术作品中，我们可以看出玛雅人和托尔特克人的世界观和宇宙观。';

  @override
  String get chichenItzaPullQuote2Author => '联合国教科文组织';

  @override
  String get chichenItzaCallout1 =>
      '奇琴伊察的遗址展示了多种建筑风格，其中包括墨西哥中部的风格以及玛雅北部低地的Puuc和Chenes风格。';

  @override
  String get chichenItzaCallout2 => '这座城市由至少1.9平方英里(5平方公里)密集的建筑组成。';

  @override
  String get chichenItzaVideoCaption => '《古玛雅101 | 国家地理》Youtube，由国家地理上传。';

  @override
  String get chichenItzaMapCaption => '显示奇琴伊察位于墨西哥尤卡坦州的地图。';

  @override
  String get chichenItzaHistoryInfo1 =>
      '奇琴伊察是玛雅文明的一座强大的地区首都，控制着从尤卡坦州中部到北海岸的一片土地。最早的象形文字在奇琴伊察发现的日期相当于公元832年，而最后一个已知的日期记录在998年的奥萨里奥神庙中。卡斯蒂略金字塔坐落在奇琴伊察北部平台。第一批看到这座金字塔的西班牙人将其命名为“卡斯蒂略” (意为“城堡”)，人们至今仍以这个名字称呼它。';

  @override
  String get chichenItzaHistoryInfo2 =>
      '该市可能是玛雅世界中人口最多样化的地区，这可能是导致该地点建筑风格多样化的一个因素。';

  @override
  String get chichenItzaConstructionInfo1 =>
      '奇琴伊察的建筑结构是由精确凿刻的石灰石块建造而成的，它们之间完美地结合在一起，不需要砂浆。这些石头建筑中许多最初是用红色，绿色，蓝色和紫色绘制的，根据该区域最容易获得的颜料来选择颜料。卡斯蒂略阶梯金字塔高约98英尺(30米)，由9个方形阶梯组成，每个阶梯高约8.4英尺(2.57米)，顶部有一座20英尺(6米)高的神庙。';

  @override
  String get chichenItzaConstructionInfo2 =>
      '这座城市是建立在破碎的地形上的，为了建立主要的建筑群，人为地将其夷为平地，对Castillo金字塔以及相关建筑物的平坦度上进行了最大的努力。这些重要的建筑物通过密集的铺装过道相互连接，称为萨科布。';

  @override
  String get chichenItzaLocationInfo1 =>
      '奇琴伊察位于墨西哥尤卡坦州的东部。它附近有四个可见的自然沉孔，称为 cenotes ，这可能会为奇琴伊察全年提供充足的水源，使其成为定居点的吸引力。';

  @override
  String get chichenItzaLocationInfo2 =>
      '在这些cenote (天然井) 中，“ Cenote Sagrado” 或 \"神圣天然井\" 被用来祭祀珍贵的物品和人类，作为对玛雅雨神Chaac的一种崇拜。';

  @override
  String get chichenItza600ce => '奇琴伊察在早期古典时期末期成为当地的重要城市';

  @override
  String get chichenItza832ce => '最早的象形文字在奇琴伊察发现';

  @override
  String get chichenItza998ce => '最后在奥萨里奥神庙记录的日期';

  @override
  String get chichenItza1100ce => '奇琴伊察作为地区中心的衰落';

  @override
  String get chichenItza1527ce => '西班牙征服者弗朗西斯科·德·蒙特霍入侵';

  @override
  String get chichenItza1535ce => '西班牙人被赶出尤卡坦半岛';

  @override
  String get chichenItzaCollectible1Title => '坠饰';

  @override
  String get chichenItzaCollectible1Icon => '首饰';

  @override
  String get chichenItzaCollectible2Title => '鸟装饰';

  @override
  String get chichenItzaCollectible2Icon => '首饰';

  @override
  String get chichenItzaCollectible3Title => 'La Prison, à Chichen-Itza';

  @override
  String get chichenItzaCollectible3Icon => '图片';

  @override
  String get christRedeemerTitle => '救世基督像';

  @override
  String get christRedeemerSubTitle => '和平的象征';

  @override
  String get christRedeemerRegionTitle => '巴西，里约热内卢';

  @override
  String get christRedeemerArtifactGeolocation => '巴西';

  @override
  String get christRedeemerPullQuote1Top => '自然与建筑的';

  @override
  String get christRedeemerPullQuote1Bottom => '完美结合';

  @override
  String get christRedeemerPullQuote2 => '一座耸立在山景中的雕像即揭示又隐藏了巴西人多样的宗教生活。';

  @override
  String get christRedeemerPullQuote2Author => '汤玛斯·特维德';

  @override
  String get christRedeemerCallout1 => '救世主基督的雕像被选中，张开双臂，象征和平。';

  @override
  String get christRedeemerCallout2 =>
      '建筑耗时9年，从1922年到1931年，花费了相当于25万美元(相当于2020年的360万美元)，于1931年10月12日开放。';

  @override
  String get christRedeemerVideoCaption =>
      '“雄伟的救世基督雕像——现代世界七大奇迹——我们在历史中见。” Youtube，由See U in History / Mythology (我们在历史/神话中见）上传。';

  @override
  String get christRedeemerMapCaption => '显示救世基督像位于巴西里约热内卢的地图。';

  @override
  String get christRedeemerHistoryInfo1 =>
      '19世纪50年代中期，为了纪念巴西末代皇帝佩德罗二世的女儿伊莎贝尔公主，人们首次提议在科尔科瓦多山上建一座基督教纪念碑，但该项目未获批准。1889年巴西成为共和国，由于政教分离，提议的雕像被驳回。';

  @override
  String get christRedeemerHistoryInfo2 =>
      '第二次“在山上建立一个雕像”的提议是里约热内卢天主教会在1920年所提出。天主教会组织了一个叫做“纪念像周”（Semana do Monumento）的活动来吸引捐款和收集签名，支持雕像的建造。这个组织的动机是他们在社会中所观察到的“无神论”。基督雕像的设计要求包括：代表基督教的十字架，一座手持地球仪的耶稣基督像，和一个象征世界的基座。';

  @override
  String get christRedeemerConstructionInfo1 =>
      '雕像由艺术家卡洛斯·奥斯瓦尔德和当地工程师海托·达·席尔瓦·科斯卡设计，由法国雕塑家保罗·兰多斯基执行雕塑。1922年，弗兰多斯基委托在巴黎的罗马尼亚雕塑家盖奥赫·莱奥尼达，后者曾在布加勒斯特和意大利的美术学院学习雕塑。';

  @override
  String get christRedeemerConstructionInfo2 =>
      '一组工程师和技师团研究了兰多斯基的设计方案，并决定以钢筋混凝土代替钢材，以便更适合十字架形状的雕像。雕像基座的混凝土来自瑞典的利姆。科斯卡和兰多斯基决定以滑石作为雕像的外层材料，因为它经久耐用，易于使用。';

  @override
  String get christRedeemerLocationInfo1 =>
      '科尔科瓦多，在葡萄牙语中是“驼背”的意思，是巴西里约热内卢中部的一座山。它是一座2329英尺(710米)高的花岗岩山峰，位于Tijuca森林国家公园。';

  @override
  String get christRedeemerLocationInfo2 =>
      '科尔科瓦多山位于市中心以西，但完全在市区范围内，从很远的地方就可以看到。';

  @override
  String get christRedeemer1850ce =>
      '天主教祭司佩德罗·玛丽亚·博斯提议在科尔科瓦多山上建一座基督教纪念碑，但该项目未获批准。';

  @override
  String get christRedeemer1921ce =>
      '罗马天主教总教区提出了一项新计划。在里约热内卢的市民向总统请愿后，该计划最终获得批准。';

  @override
  String get christRedeemer1922ce => '为了纪念巴西从葡萄牙独立，雕像的地基被隆重布置';

  @override
  String get christRedeemer1926ce => '在巴西艺术家和工程师通过竞赛选择并修改了最初的设计后，建筑正式开始施工。';

  @override
  String get christRedeemer1931ce => '雕像的建造完成，高98英尺，臂展92英尺。';

  @override
  String get christRedeemer2006ce => '为了纪念雕像的75周年，雕像基座上的一座小教堂被用来供奉阿帕雷西达圣母。';

  @override
  String get christRedeemerCollectible1Title => '雕刻牛角';

  @override
  String get christRedeemerCollectible1Icon => '雕像';

  @override
  String get christRedeemerCollectible2Title => '固定扇子';

  @override
  String get christRedeemerCollectible2Icon => '首饰';

  @override
  String get christRedeemerCollectible3Title => '手帕(两个当中的一个)';

  @override
  String get christRedeemerCollectible3Icon => '织物';

  @override
  String get colosseumTitle => '罗马斗兽场';

  @override
  String get colosseumSubTitle => '罗马的象征';

  @override
  String get colosseumRegionTitle => '意大利, 罗马市';

  @override
  String get colosseumArtifactCulture => '古罗马';

  @override
  String get colosseumArtifactGeolocation => '罗马帝国';

  @override
  String get colosseumPullQuote1Top => '至今仍是世上最大的';

  @override
  String get colosseumPullQuote1Bottom => '站立式圆形剧场';

  @override
  String get colosseumPullQuote2 => '罗马斗兽场倒下，罗马也会倒下; 罗马灭亡，世界也会灭亡。';

  @override
  String get colosseumPullQuote2Author => '拜伦';

  @override
  String get colosseumCallout1 =>
      '罗马斗兽场用来进行角斗士的比赛、动物狩猎、海战表演、处决、重要战役的历史重演、以及演出以罗马神话为基础的戏剧。';

  @override
  String get colosseumCallout2 => '罗马斗兽场是迄今为止建造的最大的古代圆形剧场，至今仍是世界上最大的站立式圆形剧场。';

  @override
  String get colosseumVideoCaption => '\"古罗马101 | 国家地理。\" Youtube，由国家地理上传。';

  @override
  String get colosseumMapCaption => '显示罗马斗兽场位于意大利罗马市的地图。';

  @override
  String get colosseumHistoryInfo1 =>
      '罗马斗兽场是位于意大利罗马市中心的椭圆形圆形剧场。与建在山坡上的罗马剧院不同，罗马斗兽场是一个完全独立的结构。';

  @override
  String get colosseumHistoryInfo2 =>
      '罗马斗兽场在中世纪前期已不再用在娱乐用途。到了6世纪晚期，圆形剧场里建起了一座小教堂，斗兽场也被改建为墓地。在座位下方的拱廊里，无数的拱形空间被改造成了住房和作坊，据记载，直到12世纪仍在出租。';

  @override
  String get colosseumConstructionInfo1 =>
      '罗马斗兽场的建造始于公元72年，在皇帝韦斯巴芗 (公元69-79年) 的统治下，并在他的继任者提图斯 (公元79-81年) 的统治下于公元80年完成。在图密善统治时期 (公元81-96年) 进行了进一步的修改。罗马斗兽场由石灰华(洞石)、凝灰岩 (火山岩) 和砖面混凝土建造而成。它的外墙是用超过350万立方英尺的石灰华石头建造的，这些石头没有用灰浆凝结，而是用300吨的铁夹子固定在一起。';

  @override
  String get colosseumConstructionInfo2 =>
      '罗马斗兽场在历史上不同时期预计可容纳5万至8万名观众，平均观众约为6.5万名。';

  @override
  String get colosseumLocationInfo1 =>
      '在公元64年的罗马大火之后，尼禄皇帝利用大部分被摧毁的地区建造了他的宏伟的Domus Aurea(“黄金屋”)。这座奢华的宫殿给尼禄的继任者带来了极大的尴尬。大约1平方英里的宫殿场地后来被填满了泥土，并盖上了新的建筑。';

  @override
  String get colosseumLocationInfo2 =>
      '在湖的原址上，在宫殿的中央，韦斯巴芗皇帝将建造了罗马斗兽场，以代表罗马的复兴。';

  @override
  String get colosseum70ce =>
      '罗马斗兽场在韦斯巴芗统治时期开始建造，位于前四位皇帝的私人湖泊之上。这样做是为了使罗马从他们的暴虐统治中复兴。';

  @override
  String get colosseum82ce => '在图密善的统治下，最上层建成，场地整个结构正式完成。';

  @override
  String get colosseum1140ce =>
      'Franangipane 和 Annibaldi 贵族家族将斗兽场改造成了堡垒。斗兽场也曾一度被用作教堂。';

  @override
  String get colosseum1490ce => '教皇亚历山大六世允许斗兽场用作采石场，用于储存和回收建筑材料。';

  @override
  String get colosseum1829ce =>
      '在经历了一千多年的破败和破坏之后，罗马斗兽场正式开始了保护工作。教皇庇护八世特别致力于这项工程。';

  @override
  String get colosseum1990ce =>
      '罗马斗兽场进行了修复工程，以确保它仍然是罗马的主要旅游景点。目前，它是意大利最大的旅游收入来源之一。';

  @override
  String get colosseumCollectible1Title => '玻璃六角双耳瓶';

  @override
  String get colosseumCollectible1Icon => '花瓶';

  @override
  String get colosseumCollectible2Title => '密特拉神杀牛的青铜牌匾';

  @override
  String get colosseumCollectible2Icon => '雕像';

  @override
  String get colosseumCollectible3Title => '\"Interno del Colosseo\" (斗兽场内)';

  @override
  String get colosseumCollectible3Icon => '图片';

  @override
  String get greatWallTitle => '万里长城';

  @override
  String get greatWallSubTitle => '地球上最长的建筑';

  @override
  String get greatWallRegionTitle => '中国';

  @override
  String get greatWallArtifactCulture => '华夏';

  @override
  String get greatWallArtifactGeolocation => '中国';

  @override
  String get greatWallPullQuote1Top => '世界上最长的';

  @override
  String get greatWallPullQuote1Bottom => '人造建筑';

  @override
  String get greatWallPullQuote2 => '长城在建筑学上的价值，足以与其在历史和战略上的重要性相媲美。';

  @override
  String get greatWallPullQuote2Author => '联合国教育、科学及文化组织';

  @override
  String get greatWallCallout1 => '长城最著名的部分主要建于明朝 (1368-1644)。';

  @override
  String get greatWallCallout2 =>
      '然而，在明朝时期，砖石在长城的许多地方都被大量使用，同时使用的还有瓦片、石灰和石头等材料。';

  @override
  String get greatWallVideoCaption => '“从空中看长城 | 国家地理频道。” Youtube，由《国家地理》上传';

  @override
  String get greatWallMapCaption => '显示长城位于中国北方的地图。';

  @override
  String get greatWallHistoryInfo1 =>
      '长城是中国古代一系列军事防御建筑的统称，它跨越了古代中原的北部边界，用来防御不同时期来自欧亚草原游牧部落的侵袭。长城的总长度超过13000英里。';

  @override
  String get greatWallHistoryInfo2 =>
      '早在公元前7世纪，就有几道墙被修建，后来中国的第一位皇帝秦始皇 (公元前220-206年) 将它们连接起来。如今，秦长城只留下断断续续的遗迹。后来，边境墙被许多朝代连续重建、维护和加强。';

  @override
  String get greatWallConstructionInfo1 =>
      '运输大量的建筑材料非常困难，所以建筑人士总是试图利用当地的资源。山上的石头被用在山脉上的建筑，而夯土则用于平原上的建筑。';

  @override
  String get greatWallConstructionInfo2 =>
      '城墙的基础、内外边缘和入口是用被切割成矩形的石头来建造的。在清朝的统治下，中国的边界延伸到城墙之外，蒙古被并入大清国，因此，工程停止了。';

  @override
  String get greatWallLocationInfo1 =>
      '不同朝代修筑的边墙创造了不同的路线。整体来说，长城的建筑沿着蒙古大草原边缘的弧线，东起辽东，西至罗布湖，北起今中俄边境，南至洮河。';

  @override
  String get greatWallLocationInfo2 =>
      '除了防御游牧部落的入侵之外，长城的其他用途还包括边境控制、对丝绸之路运输的货物征收关税、监管或鼓励贸易、以及控制移民和出境。';

  @override
  String get greatWall700bce =>
      '长城的第一个标志性建筑最初是围绕楚国的方形城墙。多年来，为了扩大和连接领土，人们修建了更多的墙。';

  @override
  String get greatWall214bce =>
      '秦始皇统一中国后，将秦国、燕国、赵国的城墙连接起来，形成了中国长城，耗时10年，耗费数十万劳工。';

  @override
  String get greatWall121bce =>
      '汉朝皇帝开始了一项为期20年的建设工程，建造长城的东西部分，包括烽火台、塔楼和城堡。目的不仅是为了防御，也是为了控制丝绸之路以及类似的贸易路线。';

  @override
  String get greatWall556ce =>
      '北齐国启动了几项建设工程，使用180多万工人来修复和延长长城的部分，增加它的长度，甚至在山西周围建造了第二道内墙。';

  @override
  String get greatWall618ce => '长城在隋朝经过修复，用来防御突厥人的攻击。隋朝前后，长城很少被使用，年久失修。';

  @override
  String get greatWall1487ce => '明代弘治皇帝将城墙分成南北线，塑造成现代的外观。从那时起，长城开始逐渐年久失修。';

  @override
  String get greatWallCollectible1Title => '廉颇蔺相如列传';

  @override
  String get greatWallCollectible1Icon => '卷轴';

  @override
  String get greatWallCollectible2Title => '龙缸';

  @override
  String get greatWallCollectible2Icon => '花瓶';

  @override
  String get greatWallCollectible3Title => '牡丹蝴蝶纹绣片';

  @override
  String get greatWallCollectible3Icon => '织物';

  @override
  String get machuPicchuTitle => '马丘比丘';

  @override
  String get machuPicchuSubTitle => '印加城塞';

  @override
  String get machuPicchuRegionTitle => '秘鲁库斯科地区';

  @override
  String get machuPicchuArtifactCulture => '印加';

  @override
  String get machuPicchuArtifactGeolocation => '南美洲';

  @override
  String get machuPicchuPullQuote1Top => '很少有能超越这座';

  @override
  String get machuPicchuPullQuote1Bottom => '石头城塞的浪漫';

  @override
  String get machuPicchuPullQuote1Author => '海勒姆·宾厄姆';

  @override
  String get machuPicchuPullQuote2 => '就它的魅力和魔力而言，世界上没有任何地方可以与它相比。';

  @override
  String get machuPicchuPullQuote2Author => '海勒姆·宾厄姆';

  @override
  String get machuPicchuCallout1 =>
      '在马丘比丘被用作皇家庄园期间，据估计约有750人居住在那里，其中大多数是长期居住的后勤人员。';

  @override
  String get machuPicchuCallout2 =>
      '印加人精通一种被称为“琢石”的技术，这种技术不需要砂浆就能将一块块切割好的石头拼在一起。';

  @override
  String get machuPicchuVideoCaption => '《马丘比丘101 | 国家地理》Youtube，由国家地理上传。';

  @override
  String get machuPicchuMapCaption => '显示马丘比丘位于秘鲁南部东科迪勒拉山脉的地图。';

  @override
  String get machuPicchuHistoryInfo1 =>
      '马丘比丘是一座建于15世纪的印加帝国城市遗迹，位于秘鲁南部的东科迪勒拉山脉，高耸在海拔2,430米（7,970英尺）的山脊上。马丘比丘建造在两个伟大的印加统治者帕查庫特克·尤潘基(1438-1471) 和图帕克·印卡·尤潘基(1472-1493)时期。';

  @override
  String get machuPicchuHistoryInfo2 =>
      '考古学家一致认为帕恰库特很可能是在赢得一场军事战役之后，下令建造这座皇家庄园作为私人休养地。但这座庄园只使用了80年就被废弃了，可能是因为西班牙人征服了印加帝国的其他地区。';

  @override
  String get machuPicchuConstructionInfo1 =>
      '中心建筑采用了经典的印加建筑风格，抛光的规则形状的干石墙。印加的墙壁有许多稳定的特点:门窗是梯形的，从下到上变窄;角通常是圆形的;内角通常略微向房间内倾斜，外角通常用“L”形的木块连接在一起。';

  @override
  String get machuPicchuConstructionInfo2 =>
      '这种精确的建造方法使马丘比丘的结构能够抵抗地震活动。这个地点本身可能是有意建在断层线上的，这样可以提供更好的排水系统和现成的碎石供应。';

  @override
  String get machuPicchuLocationInfo1 =>
      '马丘比丘位于乌鲁班巴河之上，乌鲁班巴河三面围绕着遗址，悬崖从1480英尺(450米)垂直下降到河流的底部。这座城市的位置是一个军事机密，它的深崖和陡峭的山脉提供了天然的防御。';

  @override
  String get machuPicchuLocationInfo2 =>
      '印加桥，一座横跨乌鲁班巴河的印加草绳桥，为印加军队提供了秘密入口。另一座印加桥建在马丘比丘以西的树干桥上，在悬崖上有一个20英尺(6米)的缺口。';

  @override
  String get machuPicchu1438ce => '马丘比丘由印加统治者帕查庫特克·印卡·尤潘基建造。';

  @override
  String get machuPicchu1572ce => '加的末代统治者将此地作为反抗西班牙统治的堡垒，直到他们最终被消灭。';

  @override
  String get machuPicchu1867ce => '据推测，马丘比丘最初由德国探险家奥古斯托·伯恩斯重新发现，但他的发现从未被公开。';

  @override
  String get machuPicchu1911ce =>
      '耶鲁大学的海勒姆·宾厄姆在寻找“失落的印加之城”比尔卡班巴的过程中，在当地人的带领下来到马丘比丘，并将它介绍给全世界。';

  @override
  String get machuPicchu1964ce =>
      '美国探险家吉恩·萨沃伊(Gene Savoy)彻底挖掘了周围的遗址，他在名为Espíritu Pampa的废墟中发现了一个更适合比尔卡班巴的遗址。';

  @override
  String get machuPicchu1997ce =>
      '自马丘比丘被重新发现以来，每年都有越来越多的游客前来参观，2017年的游客人数超过了140万。';

  @override
  String get machuPicchuCollectible1Title => '8点星束腰外衣';

  @override
  String get machuPicchuCollectible1Icon => '织物';

  @override
  String get machuPicchuCollectible2Title => '骆驼科小雕像';

  @override
  String get machuPicchuCollectible2Icon => '雕像';

  @override
  String get machuPicchuCollectible3Title => '双层碗';

  @override
  String get machuPicchuCollectible3Icon => '花瓶';

  @override
  String get petraTitle => '佩特拉';

  @override
  String get petraSubTitle => '失落的石城';

  @override
  String get petraRegionTitle => '约旦马安省';

  @override
  String get petraArtifactCulture => '纳巴泰';

  @override
  String get petraArtifactGeolocation => '黎凡特';

  @override
  String get petraPullQuote1Top => '一座玫瑰红的城市';

  @override
  String get petraPullQuote1Bottom => '其历史有人类历史的一半';

  @override
  String get petraPullQuote1Author => '约翰·威廉·伯根';

  @override
  String get petraPullQuote2 => '佩特拉展现了人类将贫瘠的岩石变成宏伟奇迹的能力。';

  @override
  String get petraPullQuote2Author => '爱德华·道森';

  @override
  String get petraCallout1 => '他们尤其擅长收集雨水、农业和石雕。';

  @override
  String get petraCallout2 => '佩特拉的宝库与希腊风格有显著的相似性。';

  @override
  String get petraVideoCaption => '\"佩特拉惊人的石碑 | 国家地理。\" Youtube，由国家地理上传。';

  @override
  String get petraMapCaption => '显示佩特拉位于约旦马安省的地图。';

  @override
  String get petraHistoryInfo1 =>
      '佩特拉周边地区早在公元前7000年就有人居住，纳巴泰人可能早在公元前4世纪就定居在他们王国的首都。贸易业务为纳巴泰人带来了可观的收入，佩特拉成为他们财富的焦点。纳巴泰人与他们的敌人不同，他们习惯了生活在贫瘠的沙漠中，并能够利用该地区的山区地形击退攻击。';

  @override
  String get petraHistoryInfo2 =>
      '佩特拉在公元1世纪繁荣发展，当时人口达到顶峰，估计有两万居民。大约在同一时间，它著名的卡兹尼神殿被建造，据信是纳巴泰国王阿雷塔斯四世的陵墓。进入这座城市要穿过一个称为Siq的3/4英里长(1.2公里)的峡谷，直接通往卡兹尼神殿。';

  @override
  String get petraConstructionInfo1 =>
      '佩特拉因其岩石雕刻的建筑和水管系统而闻名，被称为“红玫瑰城”。佩特拉也因其希腊风格的建筑而闻名。这种影响可以在佩特拉的许多建筑中看到，并反映了纳巴泰人与之交易的多元文化。';

  @override
  String get petraConstructionInfo2 =>
      '宝库的正面是一个破碎的三角楣，里面有一个中央圆顶，两个方尖碑在顶部似乎形成了佩特拉的岩石。在宝库底部附近，我们看到了双胞胎希腊神波鲁克斯和卡斯特，在旅途中保护旅行者。在靠近宝库顶部的地方，可以看到两个胜利雕像分别站在梭罗上的女性雕像的两侧。这个女性形象被认为是伊西斯-堤喀，伊西斯是埃及女神，而堤喀是希腊的好运女神。';

  @override
  String get petraLocationInfo1 =>
      '佩特拉位于约旦南部。它毗邻Jabal Al-Madbah山，在一个被山脉包围的盆地中，形成了从死海到亚喀巴湾的阿拉伯山谷的东侧。';

  @override
  String get petraLocationInfo2 =>
      '佩特拉周边地区早在公元前7000年就有人居住，纳巴泰人可能早在公元前4世纪就定居在他们王国的首都。考古工作只发现了纳巴泰人始于公元前2世纪的证据，那时佩特拉已经成为他们的首都。纳巴泰人是游牧的阿拉伯人，他们把佩特拉建成了一个主要的区域贸易中心，在靠近香贸易路线的地方投资。';

  @override
  String get petra1200bce => '以东人首先占领了这一地区。';

  @override
  String get petra106bce => '佩特拉成为罗马阿拉伯省的一部分。';

  @override
  String get petra551ce => '在被地震破坏后，佩特拉不再有人居住。';

  @override
  String get petra1812ce => '佩特拉被瑞士旅行家约翰·路德维希·伯克哈德重新发现。';

  @override
  String get petra1958ce => '在英国考古学院和美国东方研究中心的领导下，佩特拉的发掘工作开始。';

  @override
  String get petra1989ce => '在好莱坞电影《夺宝奇兵3：圣战奇兵》出现。';

  @override
  String get petraCollectible1Title => '骆驼和骆驼骑手';

  @override
  String get petraCollectible1Icon => '雕像';

  @override
  String get petraCollectible2Title => '器皿';

  @override
  String get petraCollectible2Icon => '瓶';

  @override
  String get petraCollectible3Title => '碗';

  @override
  String get petraCollectible3Icon => '瓶';

  @override
  String get pyramidsGizaTitle => '吉薩金字塔';

  @override
  String get pyramidsGizaSubTitle => '古代的奇迹';

  @override
  String get pyramidsGizaRegionTitle => '埃及开罗';

  @override
  String get pyramidsGizaArtifactCulture => '埃及';

  @override
  String get pyramidsGizaArtifactGeolocation => '埃及';

  @override
  String get pyramidsGizaPullQuote1Top => '在现代摩天大楼出现之前，';

  @override
  String get pyramidsGizaPullQuote1Bottom => '地球上最高的建筑';

  @override
  String get pyramidsGizaPullQuote2 => '四十个世纪从这些金字塔的顶端，俯瞰着我们。';

  @override
  String get pyramidsGizaPullQuote2Author => '拿破仑';

  @override
  String get pyramidsGizaCallout1 => '金字塔不仅是法老的坟墓，也是他死后各种物品的储存坑。';

  @override
  String get pyramidsGizaCallout2 =>
      '据估计，大金字塔由230万块石块组成。大约550万吨石灰石、8000吨花岗岩和50万吨砂浆被用于建造。';

  @override
  String get pyramidsGizaVideoCaption =>
      '“吉萨大金字塔 ｜古代埃及的奥秘 ｜英国国家地理频道。” Youtube，由英国国家地理上传。';

  @override
  String get pyramidsGizaMapCaption => '显示吉萨金字塔位于埃及大开罗地区的地图。';

  @override
  String get pyramidsGizaHistoryInfo1 =>
      '吉萨金字塔群，又名吉萨墓地，位于埃及大开罗地区的吉萨高原，包括吉萨大金字塔、卡夫拉金字塔、孟卡拉金字塔，以及与其相关的金字塔群和吉萨狮身人面像。这些建筑都建于埃及古王国第四王朝时期，即公元前2600年至公元前2500年之间。';

  @override
  String get pyramidsGizaHistoryInfo2 =>
      '吉萨金字塔和其他金字塔被认为是用来存放古埃及法老遗体的。埃及人相信，法老的灵魂中有一部分被称为他的ka，在他死后与他的尸体一起存在。为了让前法老履行他作为亡灵之王的新职责，妥善保管遗体是必要的。';

  @override
  String get pyramidsGizaConstructionInfo1 =>
      '大多数理论认为，金字塔是通过从采石场搬运巨大的石头，然后拖吊到合适的地方而建成的。在建造金字塔的过程中，建筑师可能随着时间的推移而发展了他们的技术。他们没有选择沙子作为地基，而是选择了一块基岩相对平坦的地方，这样可以提供一个稳定的地基。在仔细勘察了遗址并铺好了第一层石头之后，建筑者们用水平的方式建造金字塔，一层接着一层。';

  @override
  String get pyramidsGizaConstructionInfo2 =>
      '大金字塔内部的大部分石头似乎都是在建筑工地的南面开采的。金字塔光滑的外表是由尼罗河上开采的优质白色石灰石制成的。为了确保金字塔保持对称，外部外壳的石头都必须在高度和宽度相等。工人们可能已经在所有的石块上做了标记，以表明金字塔墙壁的角度，并仔细地修整表面，以便将石块拼在一起。在施工过程中，石头的外表面是光滑的石灰石;随着时间的推移，多余的石头已被侵蚀。';

  @override
  String get pyramidsGizaLocationInfo1 =>
      '金字塔遗址位于西部沙漠的边缘，位于尼罗河以西约5.6英里(9公里)的吉萨市，距开罗市中心西南约8英里(13公里)。';

  @override
  String get pyramidsGizaLocationInfo2 =>
      '金字塔位于西部沙漠的西北侧，它被认为是世界上辨识度最高、参观人数最多的旅游景点之一。';

  @override
  String get pyramidsGiza2575bce => '埃及人开始为第四王朝的三位法老胡夫、卡夫拉、孟卡拉建造三座金字塔。';

  @override
  String get pyramidsGiza2465bce =>
      '埃及人开始为第五和第六王朝的皇室建造 Mastabas，也就是金字塔周围更小的结构。';

  @override
  String get pyramidsGiza443bce =>
      '希腊作家希罗多德推测，金字塔是在20年的时间内建成的，共有10万多名奴隶劳工。这种假设持续了1500多年。';

  @override
  String get pyramidsGiza1925ce =>
      '王后Hetepheres的坟墓被发现，里面有家具和珠宝。经过多年的掠夺后，这座古墓是最后剩下的装满宝藏的墓穴之一。';

  @override
  String get pyramidsGiza1979ce => '金字塔被联合国教科文组织指定为世界遗产，以防止任何未经授权的掠夺和破坏行为。';

  @override
  String get pyramidsGiza1990ce =>
      '劳工区的发现表明建造金字塔的工人并不是奴隶。他们巧妙的建造方法证明，建造如此巨大的建筑只需要相对较小的劳动力。';

  @override
  String get pyramidsGizaCollectible1Title => '两张莎草纸';

  @override
  String get pyramidsGizaCollectible1Icon => '卷轴';

  @override
  String get pyramidsGizaCollectible2Title => '卡夫拉法老的脸 （碎片）';

  @override
  String get pyramidsGizaCollectible2Icon => '雕像';

  @override
  String get pyramidsGizaCollectible3Title => '首饰';

  @override
  String get pyramidsGizaCollectible3Icon => '珠宝';

  @override
  String get tajMahalTitle => '泰姬陵';

  @override
  String get tajMahalSubTitle => '人间天堂';

  @override
  String get tajMahalRegionTitle => '印度阿格拉';

  @override
  String get tajMahalArtifactCulture => '莫卧儿';

  @override
  String get tajMahalArtifactGeolocation => '印度阿格拉';

  @override
  String get tajMahalPullQuote1Top => '不仅仅是一座遗址，';

  @override
  String get tajMahalPullQuote1Bottom => '更是爱的象征。';

  @override
  String get tajMahalPullQuote1Author => '苏曼·波克雷尔';

  @override
  String get tajMahalPullQuote2 => '耸立在河岸上的泰姬陵，像永恒面颊上的一滴眼泪。';

  @override
  String get tajMahalPullQuote2Author => '泰戈尔';

  @override
  String get tajMahalCallout1 => '泰姬陵是莫卧儿王朝建筑中最杰出的典范，融合了印度、波斯和伊斯兰风格。';

  @override
  String get tajMahalCallout2 => '泰姬陵的建造花费了2.2万名工人、画家、刺绣艺术家和石匠的心血。';

  @override
  String get tajMahalVideoCaption =>
      '“印度的泰姬陵是永恒的爱情纪念碑 | 国家地理。” Youtube，由国家地理上传。';

  @override
  String get tajMahalMapCaption => '显示泰姬陵位于印度北方邦的地图。';

  @override
  String get tajMahalHistoryInfo1 =>
      '泰姬陵是位于印度北方邦阿格拉市亚穆纳河右岸的一座用白色大理石建造的陵墓。它是莫卧儿王朝皇帝沙贾汗为了纪念他最喜爱的妻子—已故皇后姬蔓·芭奴而兴建的陵墓，沙贾汗本人身故后亦合葬于此。';

  @override
  String get tajMahalHistoryInfo2 =>
      '这座陵墓是一个42英亩(17公顷)的建筑群的中心，其中包括两座清真寺建筑(对称地安置在陵墓的两侧)，一个招待所，坐落在三面城墙围成的花园中。';

  @override
  String get tajMahalConstructionInfo1 =>
      '泰姬陵的建造材料来自印度和亚洲各地。据信有超过1000头大象被用来运输建筑材料。半透明的白色大理石来自拉贾斯坦邦，碧玉来自旁遮普，玉石和水晶来自中国。绿松石来自西藏，青金石来自阿富汗，而蓝宝石则来自斯里兰卡。这座建筑的白色大理石上总共镶嵌了28种宝石和半宝石。';

  @override
  String get tajMahalConstructionInfo2 =>
      '挖掘出大约三英亩的土地，填满泥土以减少渗漏，并将其平整在河岸上方160英尺的地方。在墓区，人们挖井，填满石头和碎石，形成坟墓的基座。基座和坟墓花了大约12年的时间才完成。该建筑群的其余部分又花了10年时间完成。';

  @override
  String get tajMahalLocationInfo1 => '它是印度最著名的建筑，位于阿格拉市东部亚穆纳河南岸，阿格拉堡以东近1英里。';

  @override
  String get tajMahalLocationInfo2 =>
      '泰姬陵建在阿格拉市南部的一块土地上。沙贾汗将阿格拉市中心的一座大宫殿赠送给印度王公贾伊辛格，以换取这块土地。';

  @override
  String get tajMahal1631ce => '莫卧儿王朝皇帝沙贾汗为纪念亡妻而建造。';

  @override
  String get tajMahal1647ce => '施工完成。该项目涉及两万多名工人，占地42英亩。';

  @override
  String get tajMahal1658ce =>
      '尽管沙贾汗计划为自己的遗体建造第二座陵墓，但他的余生被儿子囚禁在阿格拉堡，第二座陵墓从未实现。';

  @override
  String get tajMahal1901ce =>
      '在经历了350多年的工厂污染和废气的腐蚀后，柯松勋爵和英国印度总督对这座遗址进行了一次重大修复。';

  @override
  String get tajMahal1984ce =>
      '为了保护这座建筑不受锡克教武装分子和一些印度教民族主义团体的影响，游客被禁止观看夜景。这项禁令将持续20年。';

  @override
  String get tajMahal1998ce => '修复和研究计划付诸行动，以帮助保护遗址。';

  @override
  String get tajMahalCollectible1Title => '有鞘的匕首';

  @override
  String get tajMahalCollectible1Icon => '首饰';

  @override
  String get tajMahalCollectible2Title => '比贾普尔家族之画';

  @override
  String get tajMahalCollectible2Icon => '图片';

  @override
  String get tajMahalCollectible3Title => '纳斯塔利克书法展板';

  @override
  String get tajMahalCollectible3Icon => '卷轴';

  @override
  String get timelineEvent2900bce => '埃及人第一次使用莎草纸';

  @override
  String get timelineEvent2700bce => '埃及古王国开始';

  @override
  String get timelineEvent2600bce => '玛雅文化出现在尤卡坦半岛';

  @override
  String get timelineEvent2560bce => '吉萨大金字塔在胡夫法老统治时期完成';

  @override
  String get timelineEvent2500bce => '猛犸象灭绝';

  @override
  String get timelineEvent2200bce => '巨石阵完成';

  @override
  String get timelineEvent2000bce => '马的驯化成功';

  @override
  String get timelineEvent1800bce => '字母文字的出现';

  @override
  String get timelineEvent890bce => '荷马完成《伊利亚特》和《奥德赛》';

  @override
  String get timelineEvent776bce => '最早记载的古代奥运会';

  @override
  String get timelineEvent753bce => '罗马的创始';

  @override
  String get timelineEvent447bce => '雅典的帕台农神庙开始建造';

  @override
  String get timelineEvent427bce => '希腊哲学家柏拉图的诞生';

  @override
  String get timelineEvent322bce => '亚里士多德去世(61岁)，历史上第一位真正的科学家';

  @override
  String get timelineEvent200bce => '纸在中国汉代发明';

  @override
  String get timelineEvent44bce => '凯撒之死; 罗马帝国建立';

  @override
  String get timelineEvent4bce => '耶稣基督的诞生';

  @override
  String get timelineEvent43ce => '罗马帝国征服不列颠';

  @override
  String get timelineEvent79ce => '庞贝城被维苏威火山摧毁';

  @override
  String get timelineEvent455ce => '罗马帝国的衰落';

  @override
  String get timelineEvent500ce => '蒂卡尔成为第一座伟大的玛雅都市';

  @override
  String get timelineEvent632ce => '伊斯兰教创始人穆罕默德 (61岁) 逝世';

  @override
  String get timelineEvent793ce => '维京人第一次入侵不列颠';

  @override
  String get timelineEvent800ce => '火药在中国唐代发明';

  @override
  String get timelineEvent1001ce => '莱夫·埃里克松于公元1001年冬天定居在今天的加拿大东部';

  @override
  String get timelineEvent1077ce => '伦敦塔开始建造';

  @override
  String get timelineEvent1117ce => '牛津大学成立';

  @override
  String get timelineEvent1199ce => '欧洲人最早使用指南针';

  @override
  String get timelineEvent1227ce => '成吉思汗去世(65岁)';

  @override
  String get timelineEvent1337ce => '英法两国为争夺统治权展开了百年战争';

  @override
  String get timelineEvent1347ce => '黑死病的第一例；到最后，这场瘟疫将使欧洲50%的人口灭绝';

  @override
  String get timelineEvent1428ce => '阿兹特克帝国在墨西哥的诞生';

  @override
  String get timelineEvent1439ce => '约翰内斯·古腾堡发明了印刷机';

  @override
  String get timelineEvent1492ce => '克里斯托弗·哥伦布到达了新大陆';

  @override
  String get timelineEvent1760ce => '工业革命的开始';

  @override
  String get timelineEvent1763ce => '瓦特蒸汽机的发明';

  @override
  String get timelineEvent1783ce => '美国独立战争结束，脱离大英帝国';

  @override
  String get timelineEvent1789ce => '法国革命开始';

  @override
  String get timelineEvent1914ce => '第一次世界大战';

  @override
  String get timelineEvent1929ce => '黑色星期二，大萧条的开始';

  @override
  String get timelineEvent1939ce => '第二次世界大战';

  @override
  String get timelineEvent1957ce => '苏联发射斯普特尼克1号';

  @override
  String get timelineEvent1969ce => '阿波罗11号在月球着陆';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String privacyStatement(Object privacyUrl) {
    return 'gskinner 非常重视对用户隐私的保护，正如$privacyUrl里所诉，gskinner 不会收集您的个人信息。';
  }

  @override
  String get pageNotFoundBackButton => '回到文明';

  @override
  String get pageNotFoundMessage => '您正在寻找的页面不存在';
}
