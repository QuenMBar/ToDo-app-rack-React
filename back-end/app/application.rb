require 'pry'
require 'json'

class Application
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path == '/tasks' && req.get?
            return 200, { 'Content-Type' => 'application/json' }, [Task.return_all.to_json]
        elsif req.path == '/tasks' && req.post?
            data = JSON.parse req.body.read
            new_task = Task.create(text: data['text'], category_id: Category.find_by(name: data['category']).id)
            return [
                200,
                { 'Content-Type' => 'application/json' },
                [{ id: new_task.id, text: new_task.text, category: Category.find(new_task.category_id).name }.to_json]
            ]
        elsif req.path.match(/tasks/) && req.delete?
            id = req.path.split('/tasks/').last
            Task.find(id).destroy
            return 200, { 'Content-Type' => 'application/json' }, [{ message: 'response success' }.to_json]
        else
            resp.write 'Path Not Found'
        end

        resp.finish
    end
end
