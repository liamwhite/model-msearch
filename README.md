# msearch wrapper for Elasticsearch::Model

Combines expensive indivdual searches into one msearch request.

```ruby
  @image_search, @top_scoring_search = Elasticsearch::Model.msearch! [
    Image.search(filter: {term: {hidden_from_users: false}}, sort: [{:created_at => :desc}], size: 25, page: @page),
    Image.search(filter: {bool: must: [{term: {hidden_from_users: false}},
                                       {range: {created_at: {gte: 'now-3d'}}}]}, sort: [{:score => :desc}], size: 4)
  ]
  @images = @image_search.records
  @top_scoring = @top_scoring_search.records
```
