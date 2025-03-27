# 电商数据分析项目

> 跨国零售客户行为分析与价值挖掘系统，涵盖数据清洗、复购率分析、RFM分层、产品聚类、客户分群及分类器全流程。


---
## 项目亮点

### 1. 核心分析能力
- **复购率趋势分析**：计算月度/季度复购率与环比增长（SQL）
- **动态RFM分层**：Tableau构建可交互客户价值看板
- **产品智能分类**：TF-IDF + K-Means聚类（6类）与词云分析
- **客户价值分群**：结合产品分类特征基于MiniBatchK-Means划分7类客户群体，
  通过Matplotlib/Seaborn可视化，定位超级VIP客户（0.77%群体贡献32%营收），设计定制化营销策略
### 2. 关键成果
- 识别0.77%超高价值客户（年均消费$67K+），并设计定制化营销策略。
- 梯度提升+投票分类器来预测客户类型实现84.46%预测准确率

---
## 项目目录

- [项目简介（About the Dataset）](#项目简介about-the-dataset)
- [数据清洗（Data Cleaning）](#数据清洗data-cleaning)
- [数据探索（Data Understanding）](#数据探索Data-Understanding)
  - [用户复购分析（Repurchase Rate Analysis）](#用户复购分析repurchase-rate-analysis)
    - [整体复购率](#整体复购率)
    - [每月复购率](#每月复购率)
    - [环比增长 MoM](#环比增长-MoM)
    - [季度环比增长 QoQ](#季度环比增长-QoQ)
  - [Tableau 可视化分析](#tableau-可视化分析)
    - [每月复购率折线图](#tableau-可视化分析)
    - [RFM 客户价值分析](#tableau-可视化分析)
    - [动态 RFM 分层](#tableau-可视化分析)
    - [客户地理分布地图](#tableau-可视化分析)
- [产品聚类分析（Product Clustering）](#产品聚类分析product-clustering)
- [客户聚类分析（Customer Segmentation）](#客户聚类分析customer-segmentation)
- [分类器建模（Customer Classification Model）](#分类器建模customer-classification-model)
- [模型对比与最终选择（Model Comparison & Final Result）](#模型对比与最终选择model-comparison--final-result)
- [结论与未来方向（Conclusion & Future Work）](#结论与未来方向conclusion--future-work)

---

## 项目简介（About the Dataset）

本项目使用电商平台的客户交易数据，旨在深入分析用户行为，并通过机器学习模型来预测客户类型与分类。

- 数据来源：这是一个跨国数据集，其中包含 2010 年 12 月 1 日至 2011 年 12 月 9 日之间发生的所有交易，
  这些交易来自一家总部位于英国且已注册的非实体店在线零售商。该公司主要销售独特的全场合礼品。
- 数据量约：500,000+ 条订单记录
- 包含字段：订单号、商品 ID、商品描述、下单数量、下单时间、商品单价、客户 ID、地理位置
- 工具与技术栈： 
  - Python (Pandas, Scikit-learn, Matplotlib/Seaborn)
  - SQL（窗口函数 + 分组分析）  
  - Tableau（动态图表 + 地图联动）  
  - Google Colab（模型训练）

---

## 数据清洗（Data Cleaning）
```
data_clean.ipynb
```
### 发现的问题

1.   数据缺失
*   CustomerID：共 135,080 条记录缺失，占比约 25%。这些数据对后续产品分类和客户分类分析至关重要，因此删除缺失的客户 ID 记录。
*   Description（商品描述）：有 1,454 条缺失值，但不会影响数值分析。

2.   数据类型不一致
*   InvoiceDate 存储为 字符串格式，需要转换为 datetime 类型以支持时间序列分析。

3.   存在异常数据
*   Quantity（商品数量）：发现 负值记录，可能是订单退货的标记。
*   UnitPrice（单价）：发现部分 单价为 0 的记录，可能是促销活动或异常数据。

### 清洗策略
1.   处理缺失值
*   删除 CustomerID 为空的行，确保后续客户分析的准确性。

2.   处理数据类型
*   将 InvoiceDate 转换为日期时间格式，以便时间窗口分析。

### 清洗后的成果
*   删除 CustomerID 为空的数据，确保每条记录都属于一个具体的客户。
*   将 InvoiceDate 转换为 datetime 类型，支持时间序列分析。
*   新增 TotalAmount（订单总金额），方便后续的产品分类和客户分类。
*   最终的数据存储为 cleaned_data.csv，用于后续 SQL 分析、产品分类、客户分类、Tableu可视化等任务。

---
## 数据探索（Data Understanding）
- 在数据探索阶段，
- 使用 SQL 查询 来分析客户的购买行为模式，特别关注 复购率（Repurchase Rate） 和 增长趋势（MoM、QoQ）。
- 利用 Tableau 进行了初步的数据分析，以更直观地理解客户行为、复购模式以及用户价值分层。

### 用户复购分析（Repurchase Rate Analysis）

#### 整体复购率
```
sql/计算整体复购率.sql
``` 
- 分析结果：
*   复购率约为 69.97%，说明大多数客户会进行多次购买。
*   但仍有 30% 的客户 仅购买过一次，需要针对这些用户提高复购策略。

#### 每月复购率
```
sql/按月份计算复购率.sql
``` 
- 分析结果：
*   2011-05 到 2011-08 复购率高达 93%，说明该季度客户忠诚度较高，可能有促销或季节性影响。
*   2011-10 复购率下降至 85.40%，显示出用户的购买活跃度降低，可能需要营销干预。
*   2011-12 复购率上升到 94.46%，可能与节假日促销有关。

#### 环比增长 MoM
```
sql/按月计算环比增长（MoM Growth）.sql
``` 
- 分析结果：
*   2011-01 复购率增长 3.71%，说明年初市场活动可能有效。
*   2011-09 ~ 2011-10 出现了 -5.12% 的下降，可能是因为市场需求疲软。
*   2011-12 复购率环比增长 7.81%，进一步确认了年底促销的正面作用。

#### 季度环比增长 QoQ
```
sql/按季度计算环比增长（QoQ Growth）.sql
```
- 分析结果：
*   2011-Q1 复购率下降 -2.68%，可能是圣诞节后市场回落。
*   2011-Q2 复购率增长 3.44%，表明市场进入稳定增长期。
*   2011-Q4 复购率下降 -6.35%，可能是由于年底订单积压，部分客户推迟购买。

#### 总结
1. 复购率稳定在 70%-94% 之间，大多数客户会进行多次购买。
2. 2011 年中期（5-8 月）复购率最高，说明该时间段市场活动有效。
3. 10 月份复购率下降至 85.40%，显示出用户活跃度下滑，需要营销干预。
4. 年底复购率增长（94.46%），假日促销可能是主要驱动力。
5. 季度环比下降（Q4） 需要关注，特别是在年末订单积压问题。

---

### Tableau 可视化分析
```
tableau.iqynb
```

#### 每月复购率折线图
- 趋势描述：
- 2011年12月复购率骤降至 21.87%，可能是节假日前后用户活跃度下降或库存消耗完毕。
- 2011年11月达到全年复购率高点（接近 40%），可能与黑五或节日促销活动相关。
- 整体来看，复购率 波动范围在 29% ~ 40% 之间，显示出稳定的复购基础。
- 战略建议：
- 重点营销月份集中在 Q4，可适当提前布局（例如：10 月中旬预热、11 月大促）
- 节后客户流失风险较大，建议在 12 月加强用户留存策略（例如：会员积分、优惠券二次唤醒）

#### Tableau RFM 分析(初步识别高价值客户)
*   目标：通过 RFM（Recency、Frequency、Monetary） 识别高价值客户，并进行客户分层。
*   R 指标（最近一次购买时间）：计算每个用户距当前时间的最后一次购买时间。数值越小，代表该用户近期仍活跃。
*   F 指标（购买频率）：计算每个用户的订单总数。数值越高，代表用户忠诚度较高。
*   M 指标（消费金额）：计算用户的总消费金额。数值越高，代表用户贡献较高的营收。
*   RFM 评分：将 R、F、M 指标按区间划分为 1-5 级，R 越低、F 和 M 越高，则用户评分越高。最终计算 RFM 总评分 = R + F + M。

#### 动态 RFM 分布切换（R/F/M 指标维度）
- 为避免固定阈值带来的分类僵化，采用参数控制实现“动态分层”：
- RFM_Threshold_High：高价值客户阈值，默认值 13，范围 3-15
- RFM_Threshold_Low：中等价值客户阈值，默认值 7，范围 3-15
- 每一类客户用圆圈代表，圆圈大小表示客户数量
- 用户可以通过滑动参数控制条，实时调整 RFM 分层标准
- 实时反映客户分布变化，为业务策略制定提供决策支持
  
#### 客户地理分布地图
- 高价值客户：
- 主要集中在西欧发达国家（如英国、德国、法国、荷兰）
- 这些国家物流通畅、消费力强、客户活跃度高

- 中价值客户：
- 分布较为广泛，涵盖部分欧洲、北非与北美市场
- 表明这些市场客户有一定潜力，后续可通过活动刺激其向高价值转化
  
- 低价值客户：
- 高比例集中在中东、南亚、部分东欧市场（如阿联酋、希腊等）
- 可能受限于物流限制、文化偏差或货币/支付等壁垒

---

## 产品聚类分析（Product Clustering）
```
Product_Clustering.ipynb
```

### 目标
*   识别不同类型的产品类别
*   了解各类别产品的特点
*   通过聚类方法对产品进行分类，以便更好地进行市场分析和推荐
### 数据预处理
*   去除空值：删除无 Description 的记录
*   文本标准化：转换为小写，移除特殊字符，进行分词、去除停用词，词干化（Stemming）

### 采用的方法
*   TF-IDF 向量化：为了进行文本分析，我们使用 TF-IDF（词频-逆文档频率） 方法，将产品描述转换为向量。选择了 1,000 个高频词 作为特征输入。
*   K-Means 聚类：为了对产品进行分类，我们采用 MiniBatchKMeans 进行聚类，并使用 肘部法则（Elbow Method） 选择最佳簇数。
*   K 值范围： 2 ~ 10
*   评估指标： SSE（误差平方和）和 Silhouette Score（轮廓系数）
  
### 最终选择最佳 K 值：6


### 结果分析
*   聚类结果
*   词云分析
*   为进一步理解各个类别的主要产品，使用 词云（WordCloud） 可视化产品类别的关键词：

*   Cluster 0：包含 "babushka", "boxes"
*   Cluster 1：包含 "lantern", "hand warmer"
*   Cluster 2：包含 "bird ornament"
*   Cluster 3：包含 "glass", "star", "frosted"
*   Cluster 4：包含 "woolly", "hottie"
*   Cluster 5：包含 "heart", "t-light holder"

---

## 客户聚类分析（Customer Segmentation）
### 选取特征  
计算客户购买行为特征，包括订单数量、总消费、购买频率、独特产品种类、最近购买时间等。
### 采用的方法
- 特征工程：为了准确反映客户的行为模式，我们提取了多个特征，包括总订单数、总消费金额、平均订单金额、购买频率、独特产品种类、最近购买时间以及各产品类别的消费占比等，共构建了 15+ 客户特征。
- MiniBatchKMeans 聚类：采用 MiniBatchKMeans 对客户进行分群，有效支持大规模数据，并提升训练速度。
- K 值范围：2 ~ 11
- 评估指标：使用肘部法则（SSE）和轮廓系数（Silhouette Score）评估不同簇数的聚类效果。


### 选取k值
- 最终确定最佳簇数为 7，并将客户划分为 7 类群体（如高价值客户、复购客户、终极 VIP 等）。


### 可视化结果

#### 客户群体占比
- 饼图显示 不同客户群体的占比，Cluster 0 约占 52%，而 Cluster 6 仅占 0.78%，但贡献了最高的销售额。

#### 一次性 vs 复购客户分析
- 柱状图对比 一次性购买客户 与 复购客户 的占比，发现约 30.03% 的客户为一次性购买用户，企业应重点关注 如何提高客户留存率。

#### 客户群体的平均订单量 vs. 平均总消费
- 通过柱状图和折线图展示 不同客户群体的平均订单量 和 总消费金额，可以直观地看出 Cluster 6 的订单量和消费金额远超其他客户群。

#### 客户群体的购买频率分布
- 通过箱线图观察 各个客户群体的购买频率分布，发现 Cluster 6 购买频率最高，而 Cluster 0 和 Cluster 4 购买频率较低。


### 总结

#### 低价值客户（Cluster 0）
*   订单数（TotalOrders_mean）: 1.84
*   总消费（TotalSpent_mean）: $315
*   购买频率（PurchaseFrequency_mean）: 0.08
*   购买的不同产品数（UniqueProductsBought_mean）: 25
*   距离上次购买天数（DaysSinceLastPurchase_mean）: 131 天
*   客户占比: 52.3%（占比最高）
*   📌 特点:
*   这些客户 购买订单较少，消费金额也很低。
*   购买间隔时间长，很多用户已经 流失。
*   他们可能是 一次性客户，仅仅尝试过一次购买，没有形成复购习惯。
*   📌 策略建议:
*   目标: 提高复购率
*   📌 行动:
*   发送促销邮件，提供 折扣优惠 吸引他们回购。
*   设计忠诚度计划，鼓励二次购买。

#### 普通客户（Cluster 4）
*   订单数（TotalOrders_mean）: 4.04
*   总消费（TotalSpent_mean）: $1,020
*   购买频率（PurchaseFrequency_mean）: 0.38
*   购买的不同产品数（UniqueProductsBought_mean）: 60
*   距离上次购买天数（DaysSinceLastPurchase_mean）: 62 天
*   客户占比: 20.4%
*   📌 特点:
*   他们购买频率 低于高价值客户，但仍然 有一定的活跃度。
*   购买金额较低，但有复购意愿。
*   📌 策略建议:
*   目标: 提升消费金额
*   📌 行动:
*   提供 个性化推荐，推送他们之前浏览过的商品。
*   发送限时折扣 提升客单价。

#### 复购客户（Cluster 1）
*   订单数（TotalOrders_mean）: 6.6
*   总消费（TotalSpent_mean）: $1,918
*   购买频率（PurchaseFrequency_mean）: 0.89
*   购买的不同产品数（UniqueProductsBought_mean）: 92
*   距离上次购买天数（DaysSinceLastPurchase_mean）: 46 天
*   客户占比: 11.87%
*   📌 特点:
*   购买频率高，但消费金额仍然偏低。
*   对品牌有一定忠诚度，但 客单价不高。
*   📌 策略建议:
*   目标: 提高单次消费金额
*   📌 行动:
*   进行 捆绑销售，增加单笔订单金额。
*   提供 VIP 会员折扣，鼓励大额消费。

#### 高价值客户（Cluster 5）
*   订单数（TotalOrders_mean）: 9.46
*   总消费（TotalSpent_mean）: $3,220
*   购买频率（PurchaseFrequency_mean）: 1.77
*   购买的不同产品数（UniqueProductsBought_mean）: 131
*   距离上次购买天数（DaysSinceLastPurchase_mean）: 33 天
*   客户占比: 7.73%
*   📌 特点:
*   消费金额高，订单数多，是高价值客户。
*   购买品类多样化，说明他们对品牌有较高的信任度。
*   📌 策略建议:
*   目标: 培养品牌忠诚度
*   📌 行动:
*   设立 VIP 会员制度，为他们提供专属福利。
*   发送 定制化推荐，基于他们的购买习惯推荐新品。

#### 超高价值客户（Cluster 2）
*   订单数（TotalOrders_mean）: 14.7
*   总消费（TotalSpent_mean）: $5,398
*   购买频率（PurchaseFrequency_mean）: 3.44
*   购买的不同产品数（UniqueProductsBought_mean）: 157
*   距离上次购买天数（DaysSinceLastPurchase_mean）: 25 天
*   客户占比: 4.43%
*   📌 特点:
*   消费金额和购买频率都非常高。
*   对品牌忠诚度极高，可能是 核心用户。
*   📌 策略建议:
*   目标: 培养超级忠诚用户
*   行动:
*   提供专属折扣，例如积分兑换系统。
*   给予他们优先购买权，例如限量版商品。

#### 超级 VIP 客户（Cluster 3）
*   订单数（TotalOrders_mean）: 25.3
*   总消费（TotalSpent_mean）: $11,587
*   购买频率（PurchaseFrequency_mean）: 10.00
*   购买的不同产品数（UniqueProductsBought_mean）: 183
*   距离上次购买天数（DaysSinceLastPurchase_mean）: 17 天
*   客户占比: 2.47%
*   📌 特点:
*   极高的购买频率和消费金额，是品牌最重要的客户。
*   购买种类最多，可能是企业客户或重度消费者。
*   📌 策略建议:
*   目标: 维护长期关系
*   📌 行动:
*   提供 个性化服务，如 私人购物顾问。
*   建立长期合作，提供 订阅制服务（如 VIP 会员月度特供）。

#### 终极 VIP 客户（Cluster 6）
*   订单数（TotalOrders_mean）: 63.3
*   总消费（TotalSpent_mean）: $67,243
*   购买频率（PurchaseFrequency_mean）: 36.77
*   购买的不同产品数（UniqueProductsBought_mean）: 390
*   距离上次购买天数（DaysSinceLastPurchase_mean）: 5.85 天
*   客户占比: 0.77%
*   📌 特点:
*   这个群体是品牌的最大贡献者，极其忠诚。
*   他们的购买频率极高，消费金额极高。
*   可能是批发商、企业用户或超级富豪消费者。
*   📌 策略建议:
*   目标: 维护终极 VIP
*   📌 行动:
*   提供白金会员服务，如私人订制 和优先配送。
*   邀请到品牌活动，增加粘性，例如VIP见面会。


*   Cluster 6 贡献了最高的销售额，但占比很少，应该提供VIP服务。
*   Cluster 0 是一次性客户，需要重点关注复购策略。
*   Cluster 3、Cluster 5 是高价值客户，应该通过会员体系锁定他们。


---

## 分类器建模（Customer Classification Model）

> 使用多个模型进行客户是否复购的预测建模任务：

- 模型尝试：
  - 逻辑回归（Logistic Regression）
  - K 近邻（KNN）
  - 决策树（Decision Tree）
  - 随机森林（Random Forest）
  - 梯度提升（Gradient Boosting）
  - AdaBoost
  - 投票分类器（Voting Classifier）

---

## 模型对比与最终选择（Model Comparison & Final Result）

| 模型           | 交叉验证准确率 | 测试集准确率 |
|----------------|----------|----------|
| 逻辑回归 | 0.6603   | 0.6663   |
|KNN  | 0.7116   | 0.7211   |
| 决策树  | 0.7925 | 0.7829 |
| 随机森林        | 0.8248   | 0.8229   |
| AdaBoost | 0.6446   | 0.6537   |
| 梯度提升 | 0.8381   | 0.8389   |
---
| 投票分类器模型选择          | 权重 | 测试集准确率 |
|---------------------------------|----------|----------|
| 随机森林，梯度提升，KNN，逻辑回归 | 2, 3, 1, 0.5   | 0.8446   |
| 随机森林，梯度提升，KNN，逻辑回归 | 3, 3, 1, 1   | 0.8411  |
| 随机森林，梯度提升，KNN，逻辑回归 | 2, 2, 2, 1   | 0.8377   |
## 结论与未来方向（Conclusion & Future Work）

- 本项目实现了从原始数据到业务洞察、可视化和机器学习预测的全流程
- 后续可继续优化方向：
  - 添加深度学习模型
  - 优化特征工程与数据维度
  - 接入实时数据库 + 自动化报表系统
  - 部署模型至云端用于线上服务

---

## 项目链接

- ⚙️ **Colab Notebook（可运行）:[https://colab.research.google.com/drive/1vRTaGIhQDwMnMSqAsJXhF77Fmis4dejV?usp=sharing]

---

## 🙋‍♀️ 作者介绍

> 本项目由 [你的名字] 完成，具有数据分析背景 + 艺术创作经验，擅长将数据洞察与美学设计结合，提升商业决策效率与客户体验。

---

