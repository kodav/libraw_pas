unit libraw_types;

interface

const
  DLLNAME = 'libraw.dll';

  LIBRAW_SUCCESS = 0;
  LIBRAW_UNSPECIFIED_ERROR = -1;
  LIBRAW_FILE_UNSUPPORTED = -2;
  LIBRAW_REQUEST_FOR_NONEXISTENT_IMAGE = -3;
  LIBRAW_OUT_OF_ORDER_CALL = -4;
  LIBRAW_NO_THUMBNAIL = -5;
  LIBRAW_UNSUPPORTED_THUMBNAIL = -6;
  LIBRAW_INPUT_CLOSED = -7;
  LIBRAW_NOT_IMPLEMENTED = -8;
  LIBRAW_UNSUFFICIENT_MEMORY = -100007;
  LIBRAW_DATA_ERROR = -100008;
  LIBRAW_IO_ERROR = -100009;
  LIBRAW_CANCELLED_BY_CALLBACK = -100010;
  LIBRAW_BAD_CROP = -100011;
  LIBRAW_TOO_BIG = -100012;
  LIBRAW_MEMPOOL_OVERFLOW = -100013;

  LIBRAW_CBLACK_SIZE = 4104;


type
  uchar = ansichar;
  ushort = word;
  float = single;
  int8_t = int8;
  uint8_t = uint8;
  pushort = ^ushort;
  pfloat = ^single;
  time_t = TDateTime;
  unsigned = Cardinal;

  libraw_raw_inset_crop_t = record
    cleft: ushort;
    ctop: ushort;
    cwidth: ushort;
    cheight: ushort;
    aspect: ushort;
  end;

  libraw_image_sizes_t = record
    raw_height: ushort;
    raw_width: ushort;
    height: ushort;
    width: ushort;
    top_margin: ushort;
    left_margin: ushort;
    iheight: ushort;
    iwidth: ushort;
    raw_pitch: unsigned;
    pixel_aspect: double;
    flip: integer;
    mask: array [0 .. Pred(8), 0 .. Pred(4)] of integer;
    raw_inset_crop: libraw_raw_inset_crop_t;
  end;

  libraw_iparams_t = record
    guard: array [0 .. Pred(4)] of uchar;
    make: array [0 .. Pred(64)] of uchar;
    model: array [0 .. Pred(64)] of uchar;
    software: array [0 .. Pred(64)] of uchar;
    normalized_make: array [0 .. Pred(64)] of uchar;
    normalized_model: array [0 .. Pred(64)] of uchar;
    maker_index: unsigned;
    raw_count: unsigned;
    dng_version: unsigned;
    is_foveon: unsigned;
    colors: integer;
    filters: unsigned;
    xtrans: array [0 .. Pred(6), 0 .. Pred(6)] of uchar;
    xtrans_abs: array [0 .. Pred(6), 0 .. Pred(6)] of uchar;
    cdesc: array [0 .. Pred(5)] of uchar;
    xmplen: unsigned;
    xmpdata: pansichar;
  end;

  libraw_nikonlens_t = record
    EffectiveMaxAp: float;
    LensIDNumber: uchar;
    LensFStops: uchar;
    MCUVersion: uchar;
    LensType: uchar;
  end;

  libraw_dnglens_t = record
    MinFocal, MaxFocal, MaxAp4MinFocal, MaxAp4MaxFocal: float;
  end;

  libraw_makernotes_lens_t = record
    LensID: UInt64;
    Lens: array [0 .. Pred(128)] of uchar;
    LensFormat: ushort; (* to characterize the image circle the lens covers *)
    LensMount: ushort; (* 'male', lens itself *)
    CamID: UInt64;
    CameraFormat: ushort; (* some of the sensor formats *)
    CameraMount: ushort; (* 'female', body throat *)
    body: array [0 .. Pred(64)] of uchar;
    FocalType: smallint;
    LensFeatures_pre: array [0 .. Pred(16)] of uchar;
    LensFeatures_suf: array [0 .. Pred(16)] of uchar;
    MinFocal: float;
    MaxFocal: float;
    MaxAp4MinFocal: float;
    MaxAp4MaxFocal: float;
    MinAp4MinFocal: float;
    MinAp4MaxFocal: float;
    MaxAp: float;
    MinAp: float;
    CurFocal: float;
    CurAp: float;
    MaxAp4CurFocal: float;
    MinAp4CurFocal: float;
    MinFocusDistance: float;
    FocusRangeIndex: float;
    LensFStops: float;
    TeleconverterID: UInt64;
    Teleconverter: array [0 .. Pred(128)] of uchar;
    AdapterID: UInt64;
    Adapter: array [0 .. Pred(128)] of uchar;
    AttachmentID: UInt64;
    Attachment: array [0 .. Pred(128)] of uchar;
    FocalUnits: ushort;
    FocalLengthIn35mmFormat: float;
  end;

  libraw_lensinfo_t = record
    MinFocal: float;
    MaxFocal: float;
    MaxAp4MinFocal: float;
    MaxAp4MaxFocal: float;
    EXIF_MaxAp: float;
    LensMake: array [0 .. Pred(128)] of uchar;
    Lens: array [0 .. Pred(128)] of uchar;
    LensSerial: array [0 .. Pred(128)] of uchar;
    InternalLensSerial: array [0 .. Pred(128)] of uchar;
    FocalLengthIn35mmFormat: ushort;
    nikon: libraw_nikonlens_t;
    dng: libraw_dnglens_t;
    makernotes: libraw_makernotes_lens_t;
  end;

  libraw_canon_makernotes_t = record
    ColorDataVer: integer;
    ColorDataSubVer: integer;
    SpecularWhiteLevel: integer;
    NormalWhiteLevel: integer;
    ChannelBlackLevel: array [0 .. Pred(4)] of integer;
    AverageBlackLevel: integer; (* multishot *)
    multishot: array [0 .. Pred(4)] of unsigned; (* metering *)
    MeteringMode: smallint;
    SpotMeteringMode: smallint;
    FlashMeteringMode: uchar;
    FlashExposureLock: smallint;
    ExposureMode: smallint;
    AESetting: smallint;
    HighlightTonePriority: uchar; (* stabilization *)
    ImageStabilization: smallint; (* focus *)
    FocusMode: smallint;
    AFPoint: smallint;
    FocusContinuous: smallint;
    AFPointsInFocus30D: smallint;
    AFPointsInFocus1D: array [0 .. Pred(8)] of uchar;
    AFPointsInFocus5D: ushort; (* bytes in reverse *)
    (* AFInfo *)
    AFAreaMode: ushort;
    NumAFPoints: ushort;
    ValidAFPoints: ushort;
    AFImageWidth: ushort;
    AFImageHeight: ushort;
    AFAreaWidths: array [0 .. Pred(61)] of smallint; (* cycle to NumAFPoints *)
    AFAreaHeights: array [0 .. Pred(61)] of smallint; (* --''-- *)
    AFAreaXPositions: array [0 .. Pred(61)] of smallint; (* --''-- *)
    AFAreaYPositions: array [0 .. Pred(61)] of smallint; (* --''-- *)
    AFPointsInFocus: array [0 .. Pred(4)] of smallint;
    (* cycle to floor((NumAFPoints+15)/16) *)
    AFPointsSelected: array [0 .. Pred(4)] of smallint; (* --''-- *)
    PrimaryAFPoint: ushort; (* flash *)
    FlashMode: smallint;
    FlashActivity: smallint;
    FlashBits: smallint;
    ManualFlashOutput: smallint;
    FlashOutput: smallint;
    FlashGuideNumber: smallint; (* drive *)
    ContinuousDrive: smallint; (* sensor *)
    SensorWidth: smallint;
    SensorHeight: smallint;
    SensorLeftBorder: smallint;
    SensorTopBorder: smallint;
    SensorRightBorder: smallint;
    SensorBottomBorder: smallint;
    BlackMaskLeftBorder: smallint;
    BlackMaskTopBorder: smallint;
    BlackMaskRightBorder: smallint;
    BlackMaskBottomBorder: smallint;
    AFMicroAdjMode: integer;
    AFMicroAdjValue: float;
    MakernotesFlip: smallint;
    RecordMode: smallint;
    SRAWQuality: smallint;
    wbi: unsigned;
    firmware: float;
    RF_lensID: smallint;
  end;

  libraw_sensor_highspeed_crop_t = record
    cleft: ushort;
    ctop: ushort;
    cwidth: ushort;
    cheight: ushort;
  end;

  libraw_nikon_makernotes_t = record
    ExposureBracketValue: double;
    ActiveDLighting: ushort;
    ShootingMode: ushort; (* stabilization *)
    ImageStabilization: array [0 .. Pred(7)] of uchar;
    VibrationReduction: uchar;
    VRMode: uchar; (* focus *)
    FocusMode: array [0 .. Pred(7)] of uchar;
    AFPoint: uchar;
    AFPointsInFocus: ushort;
    ContrastDetectAF: uchar;
    AFAreaMode: uchar;
    PhaseDetectAF: uchar;
    PrimaryAFPoint: uchar;
    AFPointsUsed: array [0 .. Pred(29)] of uchar;
    AFImageWidth: ushort;
    AFImageHeight: ushort;
    AFAreaXPposition: ushort;
    AFAreaYPosition: ushort;
    AFAreaWidth: ushort;
    AFAreaHeight: ushort;
    ContrastDetectAFInFocus: uchar; (* flash *)
    FlashSetting: array [0 .. Pred(13)] of uchar;
    FlashType: array [0 .. Pred(20)] of uchar;
    FlashExposureCompensation: array [0 .. Pred(4)] of uchar;
    ExternalFlashExposureComp: array [0 .. Pred(4)] of uchar;
    FlashExposureBracketValue: array [0 .. Pred(4)] of uchar;
    FlashMode: uchar;
    FlashExposureCompensation2: uchar;
    FlashExposureCompensation3: uchar;
    FlashExposureCompensation4: uchar;
    FlashSource: uchar;
    FlashFirmware: array [0 .. Pred(2)] of uchar;
    ExternalFlashFlags: uchar;
    FlashControlCommanderMode: uchar;
    FlashOutputAndCompensation: uchar;
    FlashFocalLength: uchar;
    FlashGNDistance: uchar;
    FlashGroupControlMode: array [0 .. Pred(4)] of uchar;
    FlashGroupOutputAndCompensation: array [0 .. Pred(4)] of uchar;
    FlashColorFilter: uchar;
    NEFCompression: ushort;
    ExposureMode: integer;
    ExposureProgram: integer;
    nMEshots: integer;
    MEgainOn: integer;
    ME_WB: array [0 .. Pred(4)] of double;
    AFFineTune: uchar;
    AFFineTuneIndex: uchar;
    AFFineTuneAdj: int8_t;
    LensDataVersion: unsigned;
    FlashInfoVersion: unsigned;
    ColorBalanceVersion: unsigned;
    key: uchar;
    NEFBitDepth: array [0 .. Pred(4)] of ushort;
    HighSpeedCropFormat: ushort; (* 1 -> 1.3x; 2 -> DX; 3 -> 5:4; 4 -> 3:2; 6 ->
      16:9; 11 -> FX uncropped; 12 -> DX uncropped;
      17 -> 1:1 *)
    SensorHighSpeedCrop: libraw_sensor_highspeed_crop_t;
    SensorWidth: ushort;
    SensorHeight: ushort;
  end;

  libraw_hasselblad_makernotes_t = record
    BaseISO: integer;
    Gain: double;
    Sensor: array [0 .. Pred(8)] of uchar;
    SensorUnit: array [0 .. Pred(64)] of uchar; (* SU *)
    HostBody: array [0 .. Pred(64)] of uchar; (* HB *)
    SensorCode: integer;
    SensorSubCode: integer;
    CoatingCode: integer;
    uncropped: integer;
    (* CaptureSequenceInitiator is based on the content of the 'model' tag
      - values like 'Pinhole', 'Flash Sync', '500 Mech.' etc in .3FR 'model' tag
      come from MAIN MENU > SETTINGS > Camera;
      - otherwise 'model' contains:
      1. if CF/CFV/CFH, SU enclosure, can be with SU type if '-' is present
      2. else if '-' is present, HB + SU type;
      3. HB;
    *)
    CaptureSequenceInitiator: array [0 .. Pred(32)] of uchar;
    (* SensorUnitConnector, makernotes 0x0015 tag:
      - in .3FR - SU side
      - in .FFF - HB side
    *)
    SensorUnitConnector: array [0 .. Pred(64)] of uchar;
    format: integer;
    (* 3FR, FFF, Imacon (H3D-39 and maybe others), Hasselblad/Phocus DNG, Adobe DNG *)
    nIFD_CM: array [0 .. Pred(2)] of integer; (* number of IFD containing CM *)
    RecommendedCrop: array [0 .. Pred(2)] of integer;
    (* mnColorMatrix is in makernotes tag 0x002a;
      not present in .3FR files and Imacon/H3D-39 .FFF files;
      when present in .FFF and Phocus .DNG files, it is a copy of CM1 from .3FR;
      available samples contain all '1's in the first 3 elements
    *)
    mnColorMatrix: array [0 .. Pred(4), 0 .. Pred(3)] of double;
  end;

  libraw_fuji_info_t = record
    ExpoMidPointShift: float;
    DynamicRange: ushort;
    FilmMode: ushort;
    DynamicRangeSetting: ushort;
    DevelopmentDynamicRange: ushort;
    AutoDynamicRange: ushort;
    DRangePriority: ushort;
    DRangePriorityAuto: ushort;
    DRangePriorityFixed: ushort; (*
      tag 0x9200, converted to BrightnessCompensation
      F700, S3Pro, S5Pro, S20Pro, S200EXR
      E550, E900, F810, S5600, S6500fd, S9000, S9500, S100FS
    *)
    BrightnessCompensation: float; (* in EV, if =4, raw data * 2^4 *)
    FocusMode: ushort;
    AFMode: ushort;
    FocusPixel: array [0 .. Pred(2)] of ushort;
    ImageStabilization: array [0 .. Pred(3)] of ushort;
    FlashMode: ushort;
    WB_Preset: ushort; (* ShutterType:
      0 - mechanical
      1 = electronic
      2 = electronic, long shutter speed
      3 = electronic, front curtain
    *)
    ShutterType: ushort;
    ExrMode: ushort;
    Macro: ushort;
    Rating: unsigned; (* CropMode:
      1 - FF on GFX,
      2 - sports finder (mechanical shutter),
      4 - 1.25x crop (electronic shutter, continuous high)
    *)
    CropMode: ushort;
    FrameRate: ushort;
    FrameWidth: ushort;
    FrameHeight: ushort;
    SerialSignature: array [0 .. Pred($0C + 1)] of uchar;
    RAFVersion: array [0 .. Pred(4 + 1)] of uchar;
    RAFDataVersion: ushort;
    isTSNERDTS: integer; (* DriveMode:
      0 - single frame
      1 - continuous low
      2 - continuous high
    *)
    DriveMode: smallint;
  end;

  libraw_olympus_makernotes_t = record
    SensorCalibration: array [0 .. Pred(2)] of integer;
    FocusMode: array [0 .. Pred(2)] of ushort;
    AutoFocus: ushort;
    AFPoint: ushort;
    AFAreas: array [0 .. Pred(64)] of unsigned;
    AFPointSelected: array [0 .. Pred(5)] of double;
    AFResult: ushort;
    DriveMode: array [0 .. Pred(5)] of ushort;
    ColorSpace: ushort;
    AFFineTune: uchar;
    AFFineTuneAdj: array [0 .. Pred(3)] of smallint;
    CameraType2: array [0 .. Pred(6)] of uchar;
  end;

  libraw_panasonic_makernotes_t = record
    Compression: ushort; (* Compression:
      34826 (Panasonic RAW 2): LEICA DIGILUX 2;
      34828 (Panasonic RAW 3): LEICA D-LUX 3; LEICA V-LUX 1; Panasonic DMC-LX1;
      Panasonic DMC-LX2; Panasonic DMC-FZ30; Panasonic DMC-FZ50; 34830 (not in
      exiftool): LEICA DIGILUX 3; Panasonic DMC-L1; 34316 (Panasonic RAW 1):
      others (LEICA, Panasonic, YUNEEC);
    *)
    BlackLevelDim: ushort;
    BlackLevel: array [0 .. Pred(8)] of float;
    multishot: unsigned; (* 0 is Off, 65536 is Pixel Shift *)
    gamma: float;
    HighISOMultiplier: array [0 .. Pred(3)] of integer; (* 0->R, 1->G, 2->B *)
  end;

  libraw_pentax_makernotes_t = record
    FocusMode: ushort;
    AFPointSelected: ushort;
    AFPointsInFocus: unsigned;
    FocusPosition: ushort;
    DriveMode: array [0 .. Pred(4)] of uchar;
    AFAdjustment: smallint;
    MultiExposure: uchar; (* last bit is not "1" if ME is not used *)
    Quality: ushort; (* 4 is raw, 7 is raw w/ pixel shift, 8 is raw w/ dynamic
      pixel shift *)
    (* uchar AFPointMode; *)
    (* uchar SRResult; *)
    (* uchar ShakeReduction; *)
  end;

  libraw_samsung_makernotes_t = record
    ImageSizeFull: array [0 .. Pred(4)] of unsigned;
    ImageSizeCrop: array [0 .. Pred(4)] of unsigned;
    ColorSpace: array [0 .. Pred(2)] of integer;
    key: array [0 .. Pred(11)] of unsigned;
    DigitalGain: double; (* PostAEGain, digital stretch *)
    DeviceType: integer;
    LensFirmware: array [0 .. Pred(32)] of uchar;
  end;

  libraw_kodak_makernotes_t = record
    BlackLevelTop: ushort;
    BlackLevelBottom: ushort;
    offset_left: smallint;
    offset_top: smallint; (* KDC files, negative values or zeros *)
    clipBlack: ushort;
    clipWhite: ushort; (* valid for P712, P850, P880 *)
    romm_camDaylight: array [0 .. Pred(3), 0 .. Pred(3)] of float;
    romm_camTungsten: array [0 .. Pred(3), 0 .. Pred(3)] of float;
    romm_camFluorescent: array [0 .. Pred(3), 0 .. Pred(3)] of float;
    romm_camFlash: array [0 .. Pred(3), 0 .. Pred(3)] of float;
    romm_camCustom: array [0 .. Pred(3), 0 .. Pred(3)] of float;
    romm_camAuto: array [0 .. Pred(3), 0 .. Pred(3)] of float;
    val018percent: ushort;
    val100percent: ushort;
    val170percent: ushort;
    MakerNoteKodak8a: smallint;
    ISOCalibrationGain: float;
    AnalogISO: float;
  end;

  libraw_p1_makernotes_t = record
    software: array [0 .. Pred(64)] of uchar; (* tag 0x0203 *)
    SystemType: array [0 .. Pred(64)] of uchar; (* tag 0x0204 *)
    FirmwareString: array [0 .. Pred(256)] of uchar; (* tag 0x0301 *)
    SystemModel: array [0 .. Pred(64)] of uchar;
  end;

  libraw_sony_info_t = record
    CameraType: ushort;
    Sony0x9400_version: uchar; (* 0 if not found/deciphered, 0xa, 0xb, 0xc
      following exiftool convention *)
    Sony0x9400_ReleaseMode2: uchar;
    Sony0x9400_SequenceImageNumber: unsigned;
    Sony0x9400_SequenceLength1: uchar;
    Sony0x9400_SequenceFileNumber: unsigned;
    Sony0x9400_SequenceLength2: uchar;
    AFAreaModeSetting: uint8_t;
    FlexibleSpotPosition: array [0 .. Pred(2)] of ushort;
    AFPointSelected: uint8_t;
    AFPointsUsed: array [0 .. Pred(10)] of uint8_t;
    AFTracking: uint8_t;
    AFType: uint8_t;
    FocusLocation: array [0 .. Pred(4)] of ushort;
    AFMicroAdjValue: int8_t;
    AFMicroAdjOn: int8_t;
    AFMicroAdjRegisteredLenses: uchar;
    VariableLowPassFilter: ushort;
    LongExposureNoiseReduction: unsigned;
    HighISONoiseReduction: ushort;
    HDR: array [0 .. Pred(2)] of ushort;
    group2010: ushort;
    real_iso_offset: ushort;
    MeteringMode_offset: ushort;
    ExposureProgram_offset: ushort;
    ReleaseMode2_offset: ushort;
    MinoltaCamID: unsigned;
    firmware: float;
    ImageCount3_offset: ushort;
    ImageCount3: unsigned;
    ElectronicFrontCurtainShutter: unsigned;
    MeteringMode2: ushort;
    SonyDateTime: array [0 .. Pred(20)] of uchar;
    ShotNumberSincePowerUp: unsigned;
    PixelShiftGroupPrefix: ushort;
    PixelShiftGroupID: unsigned;
    nShotsInPixelShiftGroup: uchar;
    numInPixelShiftGroup: uchar; (* '0' if ARQ, first shot in the group has '1'
      here *)
    prd_ImageHeight: ushort;
    prd_ImageWidth: ushort;
    prd_RawBitDepth: ushort;
    prd_StorageMethod: ushort; (* 82 -> Padded; 89 -> Linear *)
    prd_BayerPattern: ushort; (* 0 -> not valid; 1 -> RGGB; 4 -> GBRG *)
    SonyRawFileType: ushort; (* takes precedence over RAWFileType and Quality:
      0  for uncompressed 14-bit raw
      1  for uncompressed 12-bit raw
      2  for compressed raw
      3  for lossless compressed raw
    *)
    RAWFileType: ushort; (* takes precedence over Quality
      0 for compressed raw, 1 for uncompressed;
    *)
    Quality: unsigned; (* 0 or 6 for raw, 7 or 8 for compressed raw *)
    FileFormat: ushort; (* 1000 SR2
      2000 ARW 1.0
      3000 ARW 2.0
      3100 ARW 2.1
      3200 ARW 2.2
      3300 ARW 2.3
      3310 ARW 2.3.1
      3320 ARW 2.3.2
      3330 ARW 2.3.3
      3350 ARW 2.3.5
    *)
  end;

  libraw_metadata_common_t = record
    FlashEC: float;
    FlashGN: float;
    CameraTemperature: float;
    SensorTemperature: float;
    SensorTemperature2: float;
    LensTemperature: float;
    AmbientTemperature: float;
    BatteryTemperature: float;
    exifAmbientTemperature: float;
    exifHumidity: float;
    exifPressure: float;
    exifWaterDepth: float;
    exifAcceleration: float;
    exifCameraElevationAngle: float;
    real_ISO: float;
    exifExposureIndex: float;
    ColorSpace: ushort;
{$IFDEF MSWINDOWS}
    firmware: array [0 .. Pred(128)] of uchar;
{$ELSE}
    firmware: array [0 .. Pred(128+17)] of uchar;
{$ENDIF}
  end;

  libraw_makernotes_t = record
    canon: libraw_canon_makernotes_t;
    nikon: libraw_nikon_makernotes_t;
    hasselblad: libraw_hasselblad_makernotes_t;
    fuji: libraw_fuji_info_t;
    olympus: libraw_olympus_makernotes_t;
    sony: libraw_sony_info_t;
    kodak: libraw_kodak_makernotes_t;
    panasonic: libraw_panasonic_makernotes_t;
    pentax: libraw_pentax_makernotes_t;
    phaseone: libraw_p1_makernotes_t;
    samsung: libraw_samsung_makernotes_t;
    common: libraw_metadata_common_t;
  end;

  libraw_shootinginfo_t = record
    DriveMode: smallint;
    FocusMode: smallint;
    MeteringMode: smallint;
    AFPoint: smallint;
    ExposureMode: smallint;
    ExposureProgram: smallint;
    ImageStabilization: smallint;
    BodySerial: array [0 .. Pred(64)] of uchar;
    InternalBodySerial: array [0 .. Pred(64)] of uchar;
    (* this may be PCB or sensor serial, depends on
      make/model *)
  end;

  libraw_output_params_t = record
    greybox: array [0 .. Pred(4)] of unsigned; (* -A  x1 y1 x2 y2 *)
    cropbox: array [0 .. Pred(4)] of unsigned; (* -B x1 y1 x2 y2 *)
    aber: array [0 .. Pred(4)] of double; (* -C *)
    gamm: array [0 .. Pred(6)] of double; (* -g *)
    user_mul: array [0 .. Pred(4)] of float; (* -r mul0 mul1 mul2 mul3 *)
    shot_select: unsigned; (* -s *)
    bright: float; (* -b *)
    threshold: float; (* -n *)
    half_size: integer; (* -h *)
    four_color_rgb: integer; (* -f *)
    highlight: integer; (* -H *)
    use_auto_wb: integer; (* -a *)
    use_camera_wb: integer; (* -w *)
    use_camera_matrix: integer; (* +M/-M *)
    output_color: integer; (* -o *)
    output_profile: pansichar; (* -o *)
    camera_profile: pansichar; (* -p *)
    bad_pixels: pansichar; (* -P *)
    dark_frame: pansichar; (* -K *)
    output_bps: integer; (* -4 *)
    output_tiff: integer; (* -T *)
    user_flip: integer; (* -t *)
    user_qual: integer; (* -q *)
    user_black: integer; (* -k *)
    user_cblack: array [0 .. Pred(4)] of integer;
    user_sat: integer; (* -S *)
    med_passes: integer; (* -m *)
    auto_bright_thr: float;
    adjust_maximum_thr: float;
    no_auto_bright: integer; (* -W *)
    use_fuji_rotate: integer; (* -j *)
    green_matching: integer; (* DCB parameters *)
    dcb_iterations: integer;
    dcb_enhance_fl: integer;
    fbdd_noiserd: integer;
    exp_correc: integer;
    exp_shift: float;
    exp_preser: float; (* Raw speed *)
    use_rawspeed: integer; (* DNG SDK *)
    use_dngsdk: integer; (* Disable Auto-scale *)
    no_auto_scale: integer; (* Disable intepolation *)
    no_interpolation: integer; (* int x3f_flags; *)
    (* Sony ARW2 digging mode *)
    (* int sony_arw2_options; *)
    raw_processing_options: unsigned;
    max_raw_memory_mb: unsigned;
    sony_arw2_posterization_thr: integer; (* Nikon Coolscan *)
    coolscan_nef_gamma: float;
    p4shot_order: array [0 .. Pred(5)] of uchar; (* Custom camera list *)
    custom_camera_strings : PAnsiChar;
  end;

  libraw_internal_output_params_t = record
    mix_green: unsigned;
    raw_color: unsigned;
    zero_is_bad: unsigned;
    shrink: ushort;
    fuji_width: ushort;
  end;

  ph1_t = record
    format: integer;
    key_off: integer;
    tag_21a: integer;
    t_black: integer;
    split_col: integer;
    black_col: integer;
    split_row: integer;
    black_row: integer;
    tag_210: float;
  end;

  libraw_dng_color_t = record
    parsedfields: unsigned;
    illuminant: ushort;
    calibration: array [0 .. Pred(4), 0 .. Pred(4)] of float;
    colormatrix: array [0 .. Pred(4), 0 .. Pred(3)] of float;
    forwardmatrix: array [0 .. Pred(3), 0 .. Pred(4)] of float;
  end;

  libraw_dng_levels_t = record
    parsedfields: unsigned;
    dng_cblack: array [0 .. Pred(LIBRAW_CBLACK_SIZE)] of unsigned;
    dng_black: unsigned;
    dng_fcblack: array [0 .. Pred(LIBRAW_CBLACK_SIZE)] of float;
    dng_fblack: float;
    dng_whitelevel: array [0 .. Pred(4)] of unsigned;
    default_crop: array [0 .. Pred(4)] of unsigned; (* Origin and size *)
    preview_colorspace: unsigned;
    analogbalance: array [0 .. Pred(4)] of float;
    asshotneutral: array [0 .. Pred(4)] of float;
    baseline_exposure: float;
    LinearResponseLimit: float;
  end;

  libraw_P1_color_t = record
    romm_cam: array [0 .. Pred(9)] of float;
  end;

  libraw_colordata_t = record
    curve: array [0 .. Pred($10000)] of ushort;
    cblack: array [0 .. Pred(LIBRAW_CBLACK_SIZE)] of unsigned;
    black: unsigned;
    data_maximum: unsigned;
    maximum: unsigned;
    linear_max: array [0 .. Pred(4)] of integer;
    fmaximum: float;
    fnorm: float;
    white: array [0 .. Pred(8), 0 .. Pred(8)] of ushort;
    cam_mul: array [0 .. Pred(4)] of float;
    pre_mul: array [0 .. Pred(4)] of float;
    cmatrix: array [0 .. Pred(3), 0 .. Pred(4)] of float;
    ccm: array [0 .. Pred(3), 0 .. Pred(4)] of float;
    rgb_cam: array [0 .. Pred(3), 0 .. Pred(4)] of float;
    cam_xyz: array [0 .. Pred(4), 0 .. Pred(3)] of float;
    phase_one_data: ph1_t;
    flash_used: float;
    canon_ev: float;
    model2: array [0 .. Pred(64)] of uchar;
    UniqueCameraModel: array [0 .. Pred(64)] of uchar;
    LocalizedCameraModel: array [0 .. Pred(64)] of uchar;
    ImageUniqueID: array [0 .. Pred(64)] of uchar;
    RawDataUniqueID: array [0 .. Pred(17)] of uchar;
    OriginalRawFileName: array [0 .. Pred(64)] of uchar;
    profile: pinteger;
    profile_length: unsigned;
    black_stat: array [0 .. Pred(8)] of unsigned;
    dng_color: array [0 .. Pred(2)] of libraw_dng_color_t;
    dng_levels: libraw_dng_levels_t;
    WB_Coeffs: array [0 .. Pred(256), 0 .. Pred(4)] of integer;
    (* R, G1, B, G2 coeffs *)
    WBCT_Coeffs: array [0 .. Pred(64), 0 .. Pred(5)] of float;
    (* CCT, than R, G1, B, G2 coeffs *)
    as_shot_wb_applied: integer;
    P1_color: array [0 .. Pred(2)] of libraw_P1_color_t;
    raw_bps: unsigned; (* for Phase One, raw format *)
    (* Phase One raw format values, makernotes tag 0x010e:
      0    Name unknown
      1    "RAW 1"
      2    "RAW 2"
      3    "IIQ L"
      4    Never seen
      5    "IIQ S"
      6    "IIQ S v.2"
      7    Never seen
      8    Name unknown
    *)
    ExifColorSpace: integer;
  end;

  ushort4 = array [0 .. Pred(4)] of ushort;
  pushort4 = ^ushort4;

  ushort3 = array [0 .. Pred(3)] of ushort;
  pushort3 = ^ushort4;

  float3 = array [0 .. Pred(3)] of float;
  pfloat3 = ^float3;

  smallint2 = array [0 .. Pred(2)] of smallint;
  psmallint2 = ^smallint2;

  libraw_rawdata_t = record
    raw_alloc: pinteger; (* really allocated bitmap *)
    (* alias to single_channel variant *)
    raw_image: pushort; (* alias to 4-channel variant *)
    color4_image: pushort4;
    (* alias to 3-color variand decoded by RawSpeed *)
    color3_image: pushort3; (* float bayer *)
    float_image: pfloat; (* float 3-component *)
    float3_image: pfloat3; (* float 4-component *)
    float4_image: pushort4;
    (* Phase One black level data; *)
    ph1_cblack: psmallint2;
    ph1_rblack: psmallint2;
    (* save color and sizes here, too.... *)
    iparams: libraw_iparams_t;
    sizes: libraw_image_sizes_t;
    ioparams: libraw_internal_output_params_t;
    color: libraw_colordata_t;
  end;

  libraw_gps_info_t = record
    latitude: array [0 .. Pred(3)] of float; (* Deg,min,sec *)
    longitude: array [0 .. Pred(3)] of float; (* Deg,min,sec *)
    gpstimestamp: array [0 .. Pred(3)] of float; (* Deg,min,sec *)
    altitude: float;
    altref: uchar;
    latref: uchar;
    longref: uchar;
    gpsstatus: uchar;
    gpsparsed: uchar;
  end;

  libraw_imgother_t = record
    iso_speed: float;
    shutter: float;
    aperture: float;
    focal_len: float;
    timestamp: time_t;
    shot_order: unsigned;
    gpsdata: array [0 .. Pred(32)] of unsigned;
    parsed_gps: libraw_gps_info_t;
    desc: array [0 .. Pred(512)] of uchar;
    artist: array [0 .. Pred(64)] of uchar;
    analogbalance: array [0 .. Pred(4)] of float;
  end;

  // LIBRAW_THUMBNAIL_UNKNOWN = 0;
  // LIBRAW_THUMBNAIL_JPEG = 1;
  // LIBRAW_THUMBNAIL_BITMAP = 2;
  // LIBRAW_THUMBNAIL_BITMAP16 = 3;
  // LIBRAW_THUMBNAIL_LAYER = 4;
  // LIBRAW_THUMBNAIL_ROLLEI = 5;

  LibRaw_thumbnail_formats = set of (LIBRAW_THUMBNAIL_UNKNOWN,
    LIBRAW_THUMBNAIL_JPEG, LIBRAW_THUMBNAIL_BITMAP, LIBRAW_THUMBNAIL_BITMAP16,
    LIBRAW_THUMBNAIL_LAYER, LIBRAW_THUMBNAIL_ROLLEI);

  LibRaw_image_formats = set of (LIBRAW_IMAGE_JPEG, LIBRAW_IMAGE_BITMAP);

  libraw_thumbnail_t = record
    tformat: integer;
    twidth: ushort;
    theight: ushort;
    tlength: unsigned;
    tcolors: integer;
    thumb: pansichar;
  end;

  libraw_data_t = record
    image: pushort4;
    sizes: libraw_image_sizes_t;
    idata: libraw_iparams_t;
    Lens: libraw_lensinfo_t;
    makernotes: libraw_makernotes_t;
    shootinginfo: libraw_shootinginfo_t;
    params: libraw_output_params_t;
    progress_flags: unsigned;
    process_warnings: unsigned;
    color: libraw_colordata_t;
    other: libraw_imgother_t;
    thumbnail: libraw_thumbnail_t;
    rawdata: libraw_rawdata_t;
    parent_class: pinteger;
  end;
  plibraw_data_t = ^libraw_data_t;

  libraw_processed_image_t = record
    type_: integer;
    height: ushort;
    width: ushort;
    colors: ushort;
    bits: ushort;
    data_size: uint32;
    data: array [0..0] of ansichar;
  end;
  plibraw_processed_image_t = ^libraw_processed_image_t;

  tppm_header = record

  end;

  function libraw_versionNumber(): Integer; stdcall; external DLLNAME name 'libraw_versionNumber';
  function libraw_version(): PAnsiChar; stdcall; external DLLNAME name 'libraw_version';
  function libraw_unpack_thumb(libraw_data_t : plibraw_data_t): Integer; stdcall; external DLLNAME name 'libraw_unpack_thumb';
  function libraw_open_file(libraw_data_t : plibraw_data_t; const filename : PAnsiChar): Integer; stdcall; external DLLNAME name 'libraw_open_file';
  function libraw_init(flags : unsigned): plibraw_data_t; stdcall; external DLLNAME name 'libraw_init';
  function libraw_unpack(libraw_data_t : plibraw_data_t): Integer; stdcall; external DLLNAME name 'libraw_unpack';
  procedure libraw_close(libraw_data_t : plibraw_data_t); stdcall; external DLLNAME name 'libraw_close';
  function libraw_dcraw_make_mem_thumb(lr : plibraw_data_t; errcode : PInteger) : plibraw_processed_image_t; stdcall; external DLLNAME name 'libraw_dcraw_make_mem_thumb';
  function libraw_dcraw_make_mem_image(lr : plibraw_data_t; errcode : PInteger) : plibraw_processed_image_t; stdcall; external DLLNAME name 'libraw_dcraw_make_mem_image';
  procedure libraw_dcraw_clear_mem(p : plibraw_processed_image_t); stdcall; external DLLNAME name 'libraw_dcraw_clear_mem';
  function libraw_dcraw_process(libraw_data_t : plibraw_data_t): Integer; stdcall; external DLLNAME name 'libraw_dcraw_process';
  function libraw_open_buffer(libraw_data_t : plibraw_data_t; buffer : Pointer; size : unsigned): Integer; stdcall; external DLLNAME name 'libraw_open_buffer';

implementation

end.
