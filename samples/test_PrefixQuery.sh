# [2013-11-22T15:32:33.990523]
curl -XHEAD 'http://127.0.0.1:9200/test-index?pretty=true'
# response status: 404
# response body: 
# [2013-11-22T15:32:33.991234]
curl -XPUT 'http://127.0.0.1:9200/test-index?pretty=true'
# response status: 200
# response body: {"ok":true,"acknowledged":true}
# [2013-11-22T15:32:34.010724]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type/_mapping?pretty=true' -d '{"test-type": {"properties": {"pos": {"type": "integer", "store": "yes"}, "uuid": {"index": "not_analyzed", "boost": 1.0, "store": "yes", "type": "string"}, "parsedtext": {"index": "analyzed", "term_vector": "with_positions_offsets", "boost": 1.0, "store": "yes", "type": "string"}, "name": {"index": "analyzed", "term_vector": "with_positions_offsets", "boost": 1.0, "store": "yes", "type": "string"}, "title": {"index": "analyzed", "term_vector": "with_positions_offsets", "boost": 1.0, "store": "yes", "type": "string"}}}}'
# response status: 200
# response body: {"ok":true,"acknowledged":true}
# [2013-11-22T15:32:34.019635]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type2/_mapping?pretty=true' -d '{"test-type2": {"_parent": {"type": "test-type"}}}'
# response status: 200
# response body: {"ok":true,"acknowledged":true}
# [2013-11-22T15:32:34.023378]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type/1?pretty=true' -d '{"position": 1, "parsedtext": "Joe Testere nice guy", "name": "Joe Tester", "uuid": "11111"}'
# response status: 201
# response body: {"ok":true,"_index":"test-index","_type":"test-type","_id":"1","_version":1}
# [2013-11-22T15:32:34.027129]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type2/1?parent=1&pretty=true' -d '{"name": "data1", "value": "value1"}'
# response status: 201
# response body: {"ok":true,"_index":"test-index","_type":"test-type2","_id":"1","_version":1}
# [2013-11-22T15:32:34.029336]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type/2?pretty=true' -d '{"position": 2, "parsedtext": "Bill Testere nice guy", "name": "Bill Baloney", "uuid": "22222"}'
# response status: 201
# response body: {"ok":true,"_index":"test-index","_type":"test-type","_id":"2","_version":1}
# [2013-11-22T15:32:34.031811]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type2/2?parent=2&pretty=true' -d '{"name": "data2", "value": "value2"}'
# response status: 201
# response body: {"ok":true,"_index":"test-index","_type":"test-type2","_id":"2","_version":1}
# [2013-11-22T15:32:34.033443]
curl -XPUT 'http://127.0.0.1:9200/test-index/test-type/3?pretty=true' -d '{"position": 3, "parsedtext": "Bill is not\n                nice guy", "name": "Bill Clinton", "uuid": "33333"}'
# response status: 201
# response body: {"ok":true,"_index":"test-index","_type":"test-type","_id":"3","_version":1}
# [2013-11-22T15:32:34.035683]
curl -XPOST 'http://127.0.0.1:9200/test-index/_refresh?pretty=true'
# response status: 200
# response body: {"ok":true,"_shards":{"total":10,"successful":5,"failed":0}}
# [2013-11-22T15:32:34.052016]
curl -XGET 'http://127.0.0.1:9200/_cluster/health?wait_for_status=green&timeout=0s&pretty=true'
# response status: 200
# response body: {"cluster_name":"elasticsearch","status":"yellow","timed_out":true,"number_of_nodes":1,"number_of_data_nodes":1,"active_primary_shards":12,"active_shards":12,"relocating_shards":0,"initializing_shards":0,"unassigned_shards":11}
# [2013-11-22T15:32:34.253916]
curl -XGET 'http://127.0.0.1:9200/test-index/_search?from=0&pretty=true&size=10' -d '{"query": {"prefix": {"name": {"prefix": "jo"}}}}'
# response status: 200
# response body: {"took":1,"timed_out":false,"_shards":{"total":5,"successful":5,"failed":0},"hits":{"total":1,"max_score":1.0,"hits":[{"_index":"test-index","_type":"test-type","_id":"1","_score":1.0, "_source" : {"position": 1, "parsedtext": "Joe Testere nice guy", "name": "Joe Tester", "uuid": "11111"}}]}}
# [2013-11-22T15:32:34.256058]
curl -XGET 'http://127.0.0.1:9200/test-index/_search?from=0&pretty=true&size=10' -d '{"query": {"prefix": {"name": {"prefix": "jo", "boost": 3}}}}'
# response status: 200
# response body: {"took":1,"timed_out":false,"_shards":{"total":5,"successful":5,"failed":0},"hits":{"total":1,"max_score":1.0,"hits":[{"_index":"test-index","_type":"test-type","_id":"1","_score":1.0, "_source" : {"position": 1, "parsedtext": "Joe Testere nice guy", "name": "Joe Tester", "uuid": "11111"}}]}}
# [2013-11-22T15:32:34.258186]
curl -XGET 'http://127.0.0.1:9200/test-index/_search?from=0&pretty=true&size=10' -d '{"query": {"prefix": {"name": {"prefix": "jo", "boost": 3.0}}}}'
# response status: 200
# response body: {"took":1,"timed_out":false,"_shards":{"total":5,"successful":5,"failed":0},"hits":{"total":1,"max_score":1.0,"hits":[{"_index":"test-index","_type":"test-type","_id":"1","_score":1.0, "_source" : {"position": 1, "parsedtext": "Joe Testere nice guy", "name": "Joe Tester", "uuid": "11111"}}]}}
# [2013-11-22T15:32:34.260410]
curl -XHEAD 'http://127.0.0.1:9200/test-index?pretty=true'
# response status: 200
# response body: 
# [2013-11-22T15:32:34.261246]
curl -XDELETE 'http://127.0.0.1:9200/test-index?pretty=true'
# response status: 200
# response body: {"ok":true,"acknowledged":true}
