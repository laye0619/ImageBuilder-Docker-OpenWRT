import random

import mistletoe
import requests
import yaml
from lxml import etree

RULE_PROVIDERS_FILENAME = 'loyalsoldier_providers.yaml'
RULE_FILENAME = 'loyalsoldier_rules.yaml'


def retrieve_config_online():
    # resp_hackl0us = requests.get(
    #     'https://ghproxy.com/https://raw.githubusercontent.com/Hackl0us/SS-Rule-Snippet/main/LAZY_RULES/Clash_Premium.yaml')
    # resp_loyalsoldier = requests.get(
    #     'https://ghproxy.com/https://raw.githubusercontent.com/Loyalsoldier/clash-rules/master/README.md')

    resp_hackl0us = requests.get(
        'https://raw.githubusercontent.com/Hackl0us/SS-Rule-Snippet/main/LAZY_RULES/Clash_Premium.yaml')
    resp_loyalsoldier = requests.get(
        'https://raw.githubusercontent.com/Loyalsoldier/clash-rules/master/README.md')

    # 处理hackl0us配置
    config_content = yaml.safe_load(resp_hackl0us.text)
    config_content['dns']['default-nameserver'] = ['223.5.5.5', '119.29.29.29']
    config_content.pop('proxies')
    config_content.pop('proxy-groups')
    config_content.pop('proxy-providers')

    providers_dict = {}
    providers_dict['rule-providers'] = config_content['rule-providers']
    with open('./clash_rule/hackl0us_providers.yaml', 'w') as f:
        f.write(yaml.dump(providers_dict, sort_keys=False))

    rules_dict = {}
    rules_dict['rules'] = config_content['rules']
    rules_dict['rules'] = [x.replace(',Proxy', ',PROXY')
                           for x in rules_dict['rules']]
    with open('./clash_rule/hackl0us_rules.yaml', 'w') as f:
        f.write(yaml.dump(rules_dict, sort_keys=False))

    config_content.pop('rule-providers')
    config_content.pop('rules')

    with open('./clash_rule/hackl0us_basic.yaml', 'w') as f:
        f.write(yaml.dump(config_content, sort_keys=False))

    # 处理loyalsoldier配置
    rendered = mistletoe.markdown(resp_loyalsoldier.text)
    target_html = etree.HTML(rendered)
    rule_providers = target_html.xpath("//pre//code")[0].text
    rules = target_html.xpath("//pre//code")[1].text
    if not rule_providers.startswith('rule-providers:') or not rules.startswith('rules:'):
        raise ValueError('Retrieve config Loyalsoldier error!')
    rule_providers_l_dict = yaml.safe_load(rule_providers)
    rules_l_dict = yaml.safe_load(rules)
    with open('./clash_rule/loyalsoldier_providers.yaml', 'w') as f:
        f.write(yaml.dump(rule_providers_l_dict, sort_keys=False))
    with open('./clash_rule/loyalsoldier_rules.yaml', 'w') as f:
        f.write(yaml.dump(rules_l_dict, sort_keys=False))


def get_basic_part():
    with open('./clash_rule/hackl0us_basic.yaml', 'r') as f:
        my_config = yaml.safe_load(f)
    return my_config


def get_proxies_and_groups_part() -> dict:
    with open('./clash_rule/my_clash_info.yaml', 'r') as f:
        my_config = yaml.safe_load(f)
    # 随机生成0-9数字，填充端口号
    port_last_number = random.randint(1, 9)
    for item in my_config['proxies']:
        item['port'] = int(float(item['port'])/10)*10+port_last_number
    return my_config


def get_rules_part(filename: str) -> dict:
    with open('./clash_rule/'+filename, 'r') as f:
        my_config = yaml.safe_load(f)
    with open('./clash_rule/my_clash_rules.yaml', 'r') as f:
        my_rules_config = yaml.safe_load(f)
    my_config['rules'] = my_rules_config['rules'] + my_config['rules']
    return my_config


def get_rule_providers_part(filename: str) -> dict:
    with open('./clash_rule/'+filename, 'r') as f:
        my_config = yaml.safe_load(f)
    return my_config


retrieve_config_online()
my_clash_config = get_basic_part()
my_clash_config.update(get_proxies_and_groups_part())
my_clash_config.update(get_rule_providers_part(RULE_PROVIDERS_FILENAME))
my_clash_config.update(get_rules_part(RULE_FILENAME))
with open('./clash_rule/my_clash_config.yaml', 'w') as f:
    f.write(yaml.dump(my_clash_config, sort_keys=False))
