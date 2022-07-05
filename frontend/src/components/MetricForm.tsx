import {SyntheticEvent, useEffect, useState} from 'react'
import {useTranslation} from 'react-i18next';
import styled from 'styled-components'
import Metric from 'types/Metric';
import AppInputText from 'components/AppInputText'
import AppButton from 'components/AppButton'
import AppInputNumber from 'components/AppInputNumber'
import AppInputDatetime from 'components/AppInputDatetime'

interface iProps {
  metric: Metric,
  onSubmit: (metric: Metric) => void,
  errors?: {[key: string]: Array<string>}
}

function MetricForm({metric, onSubmit, errors = {}}: iProps) {
  const {t} = useTranslation();
  const [name, setName] = useState(metric.name)
  const [value, setValue] = useState(metric.value)
  const [timestamp, setTimestamp] = useState(metric.timestamp)

  const onFormSubmit = (event: SyntheticEvent) => {
    event.preventDefault()

    onSubmit({name, value, timestamp})
  }

  useEffect(() => {
    setName(metric.name)
    setValue(metric.value)
    setTimestamp(metric.timestamp)
  }, [metric])

  return (
      <form onSubmit={onFormSubmit}>
        <AppInputText
          label={t('name')}
          value={name}
          onChange={setName}
          errors={errors.name}
        />

        <AppInputNumber
          label={t('value')}
          value={value}
          onChange={setValue}
          errors={errors.value}
        />

        <AppInputDatetime
          label={t('timestamp')}
          value={timestamp}
          onChange={setTimestamp}
          errors={errors.timestamp}
        />

        <ActionContainer>
          <AppButton
            onClick={onFormSubmit}
            label={t('Save')}
          />
        </ActionContainer>
      </form>
  );
}

const ActionContainer = styled.div`
  display: flex;
  flex-direction: row-reverse;
  margin-top: 1rem;
`

export default MetricForm;
