#!/usr/bin/env python

# use python2.7 and install jenkinsapi
import argparse
from jenkinsapi.jenkins import Jenkins
import json
import requests

JENKINSURL="http://localhost:8080/jenkins"
USERNAME=""
PASSWORD=""
ARTIFACTLURL = JENKINSURL + "/job/%s/%d/artifact/*zip*/archive.zip"

#TODO: read from external file
NOTIFYSERVER="http://10.101.19.135:8080/ucaradmin/apprelease/insertAppInfo.do_"

# return jenkins instance
def getServerInstance():
    server = Jenkins(JENKINSURL, USERNAME, PASSWORD)
    return server

# check this build is success or fail
def isBuildSucess(jobname, buildnum):
    server = getServerInstance()
    if(server.has_job(jobname)):
        job = server.get_job(jobname)
        build = job.get_build(buildnum)
        return build.is_good()
    return False


# get the changes before previous build
def getChanges(jobname, buildnum):
    pass


# return artiface url of this build
def getArtifaceUrl(jobname, buildnum):
    return ARTIFACTLURL % (jobname, buildnum)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('busType', type=int, help='business type: 1-drive,\
            2-member')
    parser.add_argument('appType', type=int, help='application type:\
            1-android, 2-iOS')
    parser.add_argument('buildType', type=int, help='build type:\
            1-test, 2-pre, 3-release')
    parser.add_argument('jobName', type=str, help='job name')
    parser.add_argument('buildNum', type=int, help='build number')
    parser.add_argument('buildTag', type=str, help='build tag')

    args = parser.parse_args()

    if(isBuildSucess(args.jobName, args.buildNum)):
        artifaceUrl = getArtifaceUrl(args.jobName, args.buildNum)
        msg = {'busType':args.busType, 'appType':args.appType,
               'buildType':args.busType, 'version':args.buildNum,
               'tag':args.buildTag, 'url':artifaceUrl}

        msg_json=json.dumps(msg)
        payload = {'appInfoVO': msg_json}
        r = requests.get(NOTIFYSERVER, params=payload)
        print r.status_code
