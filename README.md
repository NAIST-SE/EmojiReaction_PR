# More Than React: Investigating The Role of Emoji Reaction in GitHub Pull Requests
## Abstract
Open source software development has become more social and collaborative, evident GitHub. Since 2016, GitHub started to support more informal methods such as emoji reactions, with the goal to reduce commenting noise when reviewing any code changes to a repository. From a code review context, the extent to which emoji reactions facilitate for a more efficient review process is unknown. We execute the protocols of a registered report to mine 1,850 active repositories across seven popular languages to analyze 365,811 Pull Requests (PRs) for their emoji reactions against the review time (RQ1), first-time contributors (RQ2), comment intentions (RQ3), and the consistency of the sentiments (RQ4). Answering these four research questions, we find that the number of emoji reactions has a significant correlation with the review time; a PR submitted by a first-time contributor is less likely to receive emoji reactions, i.e., 10.4%; comments with an intention of information giving, are more likely to receive an emoji reaction; and only a small proportion of sentiments are not consistent between comments and emoji reactions, i.e., 11.8%. In these cases, the prevalent reason is when reviewers cheer up authors that admit to a mistake, i.e., acknowledge a mistake. Apart from reducing commenting noise, our work reveals that emoji reactions play a role in promoting a positive, friendly, and non-toxic open source community.

## PR Collection 
* https://github.com/yebityon/PRReactionCollector 	:hammer:

## Seven Language Original Dataset
* https://zenodo.org/record/6941932#.YuUM17lBybs
<a href="https://doi.org/10.5281/zenodo.6941932"><img src="https://zenodo.org/badge/DOI/10.5281/zenodo.6941932.svg" alt="DOI"></a>

## Automatic Intention Classifier/Sentiment Tool 
* https://github.com/tkdsheep/Intention-Mining-TSE :gear:
* http://sentistrength.wlv.ac.uk/ :gear:

## Contents
* `RQ_Datasets` - contains the datasets that are used in each RQ, and the manual classification for RQ4 (inconsistency reasons) :floppy_disk:

* `Script` - contains the script to reproduce the non-linear regression model (RQ1) :crystal_ball:

		
## Authors
- :cn: [Dong Wang](https://dong-w.github.io/) - Kyushu University
- :cn: [Tao Xiao](https://tao-xiao.github.io/) - Nara Institute of Science and Technology
- :jp: [Teyon Son](https://yebityon.hatenablog.com/) - Nara Institute of Science and Technology
- :papua_new_guinea: [Raula Gaikovina Kula](https://raux.github.io/) - Nara Institute of Science and Technology
- :jp: [Takashi Ishio](https://hideakihata.github.io/) - Nara Institute of Science and Technology
- :jp: [Yasutaka Kamei](https://posl.ait.kyushu-u.ac.jp/~kamei/) - Kyushu University
- :jp: [Kenichi Matsumoto](https://matsumotokenichi.github.io/) - Nara Institute of Science and Technology
