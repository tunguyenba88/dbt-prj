
### Using the starter project
Để tải CSDL vào link: http://courses.cms.caltech.edu/cs122/assignments/challenge1.html
Copy vào mục data
Chạy lệnh sau để lưu vào cơ sở dữ liệu
cd db
docker compose up -d

Để chạy dbt

cd tpch
dbt run
dbt test

Tạo docs:

dbt docs generate
dbt docs serve



### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
