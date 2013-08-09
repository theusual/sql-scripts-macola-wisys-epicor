SELECT  *
FROM    wierrlog

SELECT  *
FROM    wsSettings_sql

SELECT  *
FROM    wsusers

SELECT  *
FROM    wsFormDefaultSettings

SELECT  *
FROM    wsDeviceSettings
ORDER BY Device

UPDATE wsDeviceSettings SET WiSysUser = 'sjarboe'
WHERE Device = 'HQTS' and WiSysUser = 'brrogers'

INSERT INTO wsDeviceSettings
VALUES ('001','HQTS','brrogers','popbin',''),
       ('001','HQTS','brrogers','POPPutAwayLoc','')    ,
       ('001','HQTS','brrogers','popstagebin','') ,
       ('001','HQTS','brrogers','rcvgbin','') ,
       ('001','HQTS','brrogers','RCVGPutAwayLoc','') ,
       ('001','HQTS','brrogers','sfcbin','') ,
       ('001','HQTS','brrogers','SFCPutAwayLoc','')                                                                                                                                     